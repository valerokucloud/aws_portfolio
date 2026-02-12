resource "aws_apigatewayv2_api" "api_chapter4" {
  name          = "tf_API_GW_chapter4"
  description   = "Recipe Sharing app serverless API"
  protocol_type = "HTTP"
  # The API could not be "REGIONAL" because it's API v2 version.
  cors_configuration {
    allow_methods = [
      "GET",
      "POST",
      "PUT",
      "DELETE"
    ]
    allow_origins = ["*"]
    allow_headers = ["*"]
  }
}


// API GW integrations (for Lambda):
resource "aws_apigatewayv2_integration" "this" {
  for_each = local.api_routes

  api_id           = aws_apigatewayv2_api.api_chapter4.id
  integration_type = "AWS_PROXY"
  integration_uri    = aws_lambda_function.this[each.value.lambda].invoke_arn
  payload_format_version = "2.0"
}


// API GW routes (delete,post,like_recipe...) creation:
resource "aws_apigatewayv2_route" "this" {
  for_each = local.api_routes

  api_id    = aws_apigatewayv2_api.api_chapter4.id
  route_key = "${each.value.method} ${each.value.path}"
  target    = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"
}

// Allow API GW to invoke Lambdas:
resource "aws_lambda_permission" "api_gw" {
  for_each = local.api_routes

  statement_id  = "AllowInvoke-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[each.value.lambda].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api_chapter4.execution_arn}/*/*"
}


// Definining HTTP API stage:
resource "aws_apigatewayv2_stage" "apigw_stage_chapter4" {
  api_id      = aws_apigatewayv2_api.api_chapter4.id
  name        = "tf_apigw_stage_chapter4"
  auto_deploy = true
}


// Autorización JWT (Cognito User pool y Cognito User client):
resource "aws_apigatewayv2_authorizer" "jwt" {
  api_id          = aws_apigatewayv2_api.api_chapter4.id
  name            = "chapter4-jwt-authorizer"
  authorizer_type = "JWT"

  identity_sources = ["$request.header.Authorization"]

  jwt_configuration {
    issuer = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.chapter4_cognito_user_pool.id}"

    audience = [
      aws_cognito_user_pool_client.chapter4_cognito_user_pool_client.id
    ]
  }
}

