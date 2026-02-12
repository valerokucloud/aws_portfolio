locals {
  # Valeroku recipes DDB table:
  valeroku_recipes_DDB = aws_dynamodb_table.valeroku_recipes.arn

  # Inline policies (JSON only)
  IAM_inline_policies = {
    DDBReadPolicy = {
      Version = "2012-10-17"
      Statement = [{
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = local.valeroku_recipes_DDB
      }]
    }

    DDBWritePolicy = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["dynamodb:PutItem"]
        Resource = local.valeroku_recipes_DDB
      }]
    }

    DDBDeletePolicy = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["dynamodb:DeleteItem"]
        Resource = local.valeroku_recipes_DDB
      }]
    }

    DDBUpdatePolicy = {
      Version = "2012-10-17"
      Statement = [{
        Effect   = "Allow"
        Action   = ["dynamodb:UpdateItem"]
        Resource = local.valeroku_recipes_DDB
      }]
    }
  }
  # IAM managed_policies (ARNs)
  IAM_managed_policies = {
    cloudwatch_logs = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  }

  # Common Lambda policies (defined ONCE)
  common_lambda_policies = ["cloudWatch_logs"]


  # Role definition --> inline policies (LIST)
  lambda_roles = {
    tf_LambdaExecutionReadRecipeRole   = ["DDBReadPolicy"]
    tf_LambdaExecutionWriteRecipeRole  = ["DDBWritePolicy"]
    tf_LambdaExecutionDeleteRecipeRole = ["DDBDeletePolicy"]
    tf_LambdaExecutionUpdateRecipeRole = ["DDBUpdatePolicy"]
    tf_LambdaExecutionHCRole           = [""]
    tf_LambdaExecutionAuthRole         = [""]
  }


  # Final role structure definition (inline + common)
  lambda_roles_final = {
    for role, policies in local.lambda_roles :
    role => concat(
      policies,
      local.common_lambda_policies
    )
  }

  # Lambda definition:
  lambdas = {
    get_recipe = {
      function_name = "tf_get_recipe"
      zip           = "get_recipe.zip"
      role          = "tf_LambdaExecutionReadRecipeRole"
    }

    post_recipe = {
      function_name = "tf_post_recipe"
      zip           = "post_recipe.zip"
      role          = "tf_LambdaExecutionWriteRecipeRole"
    }

    delete_recipe = {
      function_name = "tf_delete_recipe"
      zip           = "delete_recipe.zip"
      role          = "tf_LambdaExecutionDeleteRecipeRole"
    }

    like_recipe = {
      function_name = "tf_like_recipe"
      zip           = "like_recipe.zip"
      role          = "tf_LambdaExecutionUpdateRecipeRole"
    }

    test_auth = {
      function_name = "tf_test_auth"
      zip           = "test_auth.zip"
      role          = "tf_LambdaExecutionAuthRole"
    }

    health_service_check = {
      function_name = "tf_health_service_check"
      zip           = "health_check.zip"
      role          = "tf_LambdaExecutionHCRole"
    }
  }
}

// API routes definition:
locals {
  api_routes = {
    get_recipe = {
      path   = "/recipes"
      method = "GET"
      lambda = "get_recipe"
    }

    post_recipe = {
      path   = "/recipes"
      method = "POST"
      lambda = "post_recipe"
    }

    delete_recipe = {
      path   = "/recipes/{id}"
      method = "DELETE"
      lambda = "delete_recipe"
    }

    like_recipe = {
      path   = "/recipes/{id}/like"
      method = "PUT"
      lambda = "like_recipe"
    }

    test_auth = {
      path   = "/auth/test"
      method = "GET"
      lambda = "test_auth"
    }

    health_service_check = {
      path   = "/health"
      method = "GET"
      lambda = "health_service_check"
    }
  }
}






