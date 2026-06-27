# S3 bucket + config:
    resource "aws_s3_bucket" "frontend" {
    bucket = var.bucket_name
    }

    resource "aws_s3_bucket_public_access_block" "frontend" {
    bucket = aws_s3_bucket.frontend.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

# Bucket policy for CloudFront:
    resource "aws_s3_bucket_policy" "frontend" {
    bucket = aws_s3_bucket.frontend.id
    policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFront"
        Effect = "Allow"

        Principal = {
          Service = "cloudfront.amazonaws.com"
        }

        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.frontend.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.frontend.arn
          }
        }
      }
    ]
  })
}
