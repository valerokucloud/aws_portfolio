output "bucket_name" {
    value = aws_s3_bucket.frontend.bucket
}

output "cloudfront_domain_name" {
    value = aws_cloudfront_distribution.frontend.domain_name
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.portfolio_v2.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.portfolio_v2.id
}

output "cognito_domain" {
  value = aws_cognito_user_pool_domain.portfolio.domain
}

output "api_gw_url" {
  value = aws_apigatewayv2_api.api_portfolio.api_endpoint
}
