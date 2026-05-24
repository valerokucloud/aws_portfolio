# Lambda trust relationship creation:
resource "aws_iam_role" "lambda" {
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
