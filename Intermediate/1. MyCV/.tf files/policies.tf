// Bucket policy that only allows access from CloudFront:
  data "aws_iam_policy_document" "CF_policy_to_S3" {
    statement {
      sid = "AllowCloudFrontServicePrincipalReadOnly"

      principals {
        type        = "Service"
        identifiers = ["cloudfront.amazonaws.com"]
      }

      actions   = [
        "s3:GetObject",
        "s3:PutObject"
      ]

      resources = ["${aws_s3_bucket.valeroku_mycv.arn}/*"]

      condition {
        test     = "StringEquals"
        variable = "AWS:SourceArn"
        values   = [aws_cloudfront_distribution.s3_distribution.arn]
      }
    }
  }

// Policy assignation to bucket:
  resource "aws_s3_bucket_policy" "S3_CF_policy" {
    bucket = aws_s3_bucket.valeroku_mycv.id
    policy = data.aws_iam_policy_document.CF_policy_to_S3.json
  }



