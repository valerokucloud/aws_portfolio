# Lambda policy (S3/CloudWatch):
  resource "aws_iam_role_policy" "lambda_policy" {
  for_each = local.lambdas
    
  role = aws_iam_role.lambda_role[each.value.role].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat(

      # S3 statement:
      length([
        for p in each.value.permissions : p
        if startswith(p,"s3:")
      ]) > 0 ? [{
        Effect = "Allow"
        Action = [
          for p in each.value.permissions : p
          if startswith(p,"s3:")
        ]
        Resource = "${aws_s3_bucket.tf_image_rek.arn}/*"
      }] : [],

      # Rekognition statement:
      length([
        for p in each.value.permissions : p
        if startswith(p,"rekognition:")
      ]) > 0 ? [{
        Effect = "Allow"
        Action = [
          for p in each.value.permissions : p
          if startswith(p,"rekognition:")
        ]
        Resource = "*"
      }] : [],

      # CloudWatch logs
      [{
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }]
    )
  })
}