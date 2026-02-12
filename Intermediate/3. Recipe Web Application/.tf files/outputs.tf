
# -------------------------------
# CloudFront
# -------------------------------
output "cloudfront_url" {
  description = "CloudFront public URL"
  value       = "https://${aws_cloudfront_distribution.CDN_recipes.domain_name}"
}


# -------------------------------
# API Gateway (HTTP API)
# -------------------------------
output "api_base_url" {
  description = "API GW default URL"
  value       = aws_apigatewayv2_api.api_chapter4.api_endpoint
}

# -------------------------------
# Cognito
# -------------------------------
output "cognito_user_pool_id" {
  description = "Cognito user pool ID"
  value       = aws_cognito_user_pool.chapter4_cognito_user_pool.id
}

output "cognito_user_pool_client_id" {
  description = "Cognito user pool ID Client (App Client)"
  value       = aws_cognito_user_pool_client.chapter4_cognito_user_pool_client.id
}


# -------------------------------
# S3
# -------------------------------
output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.tf_chapter4_s3.bucket
}
