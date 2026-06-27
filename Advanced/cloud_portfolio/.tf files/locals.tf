locals {
    # DB declaration:
        portfolio_db = aws_dynamodb_table.feedback.arn
    
    # DB inline policies (fine-grained permissions)
        DB_inline_policy = {
            DDBReadPolicy = {
                Version = "2012-10-17"
                Statement = [{
                    Effect = "Allow"
                    Action = [
                    "dynamodb:GetItem",
                    "dynamodb:Scan",
                    "dynamodb:Query"
                    ]
                    Resource = local.portfolio_db
                }]
            }

            DDBWritePolicy = {
                Version = "2012-10-17"
                Statement = [{
                    Effect = "Allow"
                    Action = ["dynamodb:PutItem"]
                    Resource = local.portfolio_db
                }]
            }

            DDBGetPolicy = {
                Version = "2012-10-17"
                Statement = [{
                    Effect   = "Allow"
                    Action   = ["dynamodb:GetItem"]
                    Resource = local.portfolio_db
                }]
            }
    }

    # Role definition + inline_policies (LIST):
    lambda_roles = {
        tf_LambdaExecutionWriteComment = ["DDBWritePolicy"]
        tf_LambdaExecutionReadComment = ["DDBReadPolicy"]
    }


    # Lambda definition:
        lambdas = {
            add_comment = {
                function_name = "tf_add_comment"
                zip = "add_comment.zip"
                role = "tf_LambdaExecutionWriteComment"
                handler = "add_comment.handler"
            }

            get_comments = {
                function_name = "tf_get_comments"
                zip = "get_comments.zip"
                role = "tf_LambdaExecutionReadComment"
                handler = "get_comments.handler"
            }
    }

    # Lambda basic execution role (CW):
        iam_managed_policies = {
            cloudwatch_logs = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    }
}