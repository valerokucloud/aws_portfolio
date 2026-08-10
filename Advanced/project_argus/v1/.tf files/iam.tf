# User creation:
resource "aws_iam_user" "camera" {
  name = "${var.project_name}-camera-${var.environment}"
}

# User policy:
resource "aws_iam_policy" "camera_s3_policy" {
  name        = "${var.project_name}-camera-s3-policy-${var.environment}"
  description = "Bucket upload permission"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.images.arn
      },

      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.images.arn}/*"
      },

      {
        Effect = "Allow"
        Action = [
          "rekognition:DetectLabels"
        ]
        Resource = "*"
      }

    ]
  })
}

# AK creation:
resource "aws_iam_access_key" "camera" {
  user = aws_iam_user.camera.name
}

# Policy attachment:
resource "aws_iam_policy_attachment" "camera" {
  name       = "camera_policy_attachment"
  users      = [aws_iam_user.camera.name]
  policy_arn = aws_iam_policy.camera_s3_policy.arn
}

