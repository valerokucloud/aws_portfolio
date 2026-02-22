# API GW definition:
    resource "aws_apigatewayv2_api" "apigw" {
        name = "tf_apigw_rekognition"
        protocol_type = "HTTP"
}

# API GW integration (2 lambdas - AWS_PROXY):
    resource "aws_apigatewayv2_integration" "lambda" {
      for_each = aws_lambda_function.this
      api_id = aws_apigatewayv2_api.apigw.id
      
      integration_type = "AWS_PROXY"
      # Integration with both lambdas:
      integration_uri = each.value.invoke_arn
      integration_method = "POST"
      payload_format_version = "2.0"
    }

# API GW routes (2 lambdas):
    resource "aws_apigatewayv2_route" "routes" {
      for_each = local.lambdas

      api_id = aws_apigatewayv2_api.apigw.id
      route_key = each.value.route
      # When a request arrives at this route --> execute this integration:
      target = "integrations/${aws_apigatewayv2_integration.lambda[each.key].id}"
    }
  
# API GW permissions --> Lambda:
  resource "aws_lambda_permission" "allow" {
    for_each = aws_lambda_function.this

    statement_id = "Allow-${each.key}"
    action = "lambda:InvokeFunction"
    function_name = each.value.function_name
    principal = "apigateway.amazonaws.com"
  }

# API GW stage definition:
  resource "aws_apigatewayv2_stage" "def_stage" {
    api_id = aws_apigatewayv2_api.apigw.id
    name = "$default"
    auto_deploy = "true"
  }