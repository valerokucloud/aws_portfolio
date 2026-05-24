// Bucket creation
resource "aws_s3_bucket" "tf_chapter4_s3" {
  bucket = "tf-valeroku-recipes"

  tags = {
    Project = "tf_valeroku_recipes"
    Service = "recipes"
  }
}


// Public access blocked:
resource "aws_s3_bucket_public_access_block" "s3_block_public_access" {
  bucket = aws_s3_bucket.tf_chapter4_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// Encryption at rest:
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_SSE" {
  bucket = aws_s3_bucket.tf_chapter4_s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


// OAI --> s3 bucket:
resource "aws_s3_bucket_policy" "s3_OAI_policy" {
  bucket = aws_s3_bucket.tf_chapter4_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontRead"
        Effect = "Allow"

        Principal = {
          AWS = aws_cloudfront_origin_access_identity.s3_OAI.iam_arn
        }

        Action = [
          "s3:GetObject"
        ]

        Resource = "${aws_s3_bucket.tf_chapter4_s3.arn}/*"
      }
    ]
  })
}
