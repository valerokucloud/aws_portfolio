resource "aws_lambda_function" "this" {
  for_each = local.lambdas

  function_name = each.value.function_name
  handler       = "${each.key}.handler"
  runtime       = "python3.9" # Runtime mod from 3.8 to 3.9
  role          = aws_iam_role.lambda[each.value.role].arn

  filename         = "${path.module}/lambda/${each.value.zip}"
  source_code_hash = filebase64sha256("${path.module}/lambda/${each.value.zip}")

  # DDB env. variable:
  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.valeroku_recipes.name
    }
  }
}

