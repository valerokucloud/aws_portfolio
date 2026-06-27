# Basic HTTP API:
  resource "aws_apigatewayv2_api" "api_portfolio" {

  name          = "portfolio-api"
  protocol_type = "HTTP"

  cors_configuration {

    allow_origins = [
    "http://localhost:4321",
    ['YOUR_DOMAIN'].xxx
    ]

    allow_methods = [
      "GET",
      "POST",
      "OPTIONS"
    ]

    allow_headers = [
      "content-type",
      "authorization"
    ]

    expose_headers = [
      "*"
    ]

    max_age = 300

  }

}

# API GW Cognito authorizer:
    resource "aws_apigatewayv2_authorizer" "cognito" {
      
      name = "portfolio-cognito-authorizer"
      api_id = aws_apigatewayv2_api.api_portfolio.id
      authorizer_type = "JWT"
      identity_sources = ["$request.header.Authorization"]

      jwt_configuration {
        audience = [aws_cognito_user_pool_client.portfolio_v2.id]

        issuer = "https://${aws_cognito_user_pool.portfolio_v2.endpoint}"
      }    
}

# Lambda integrations with API GW:
    resource "aws_apigatewayv2_integration" "lambda" {
      
      for_each = local.lambdas
      api_id = aws_apigatewayv2_api.api_portfolio.id
      
      integration_type = "AWS_PROXY"
      integration_uri = aws_lambda_function.this[each.key].invoke_arn

}

# POST /comments & GET/comments/{project} procedure (protected by Cognito):
    resource "aws_apigatewayv2_route" "add_comment" {
      
      api_id = aws_apigatewayv2_api.api_portfolio.id
      route_key = "POST /comments"
      target = "integrations/${aws_apigatewayv2_integration.lambda["add_comment"].id}"  # Lambda (destination)
      authorization_type = "JWT"
      authorizer_id = aws_apigatewayv2_authorizer.cognito.id
    }

    resource "aws_apigatewayv2_route" "get_comment" {
      
      api_id = aws_apigatewayv2_api.api_portfolio.id
      route_key = "GET /comments/{project}"
      target = "integrations/${aws_apigatewayv2_integration.lambda["get_comments"].id}"
      # No authorizer id because we are prompting the comments.
    }