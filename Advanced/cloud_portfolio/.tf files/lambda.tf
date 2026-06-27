# Lambda creation loop:
resource "aws_lambda_function" "this" {
  for_each = local.lambdas
  handler = each.value.handler
  function_name = each.value.function_name
  runtime       = "python3.9" # Runtime mod from 3.8 to 3.9
  role          = aws_iam_role.sts_role[each.value.role].arn

  filename         = "${path.module}/../lambda/${each.value.zip}"
  source_code_hash = filebase64sha256("${path.module}/../lambda/${each.value.zip}")

  # DDB env. variable:
  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.feedback.name
    }
  }
}

# Configure API Gateway to invoke the appropriate Lambda functions.
  resource "aws_lambda_permission" "apigw" {
    for_each = local.lambdas

    statement_id = "AllowExecutionFromAPIGateway-${each.key}"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.this[each.key].function_name
    principal = "apigateway.amazonaws.com"
    source_arn = "${aws_apigatewayv2_api.api_portfolio.execution_arn}/*/*"
}

# Stage definition for API GW:
  resource "aws_apigatewayv2_stage" "default" {
    api_id = aws_apigatewayv2_api.api_portfolio.id
    name = "$default"
    auto_deploy = true
  }