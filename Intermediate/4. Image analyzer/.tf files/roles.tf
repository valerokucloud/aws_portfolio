# Lambda STS role definition:
  resource "aws_iam_role" "lambda_role" {
    for_each = local.lambda_roles
    name     = each.key
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
        Effect = "Allow"
        Principal = {
            Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        }]
    })
}
