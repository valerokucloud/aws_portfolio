// Output definition:
    output "s3_bucket_name" {
    value = aws_s3_bucket.valeroku_mycv.bucket
    }

    output "aws_cloudfront_domain" {
      value = aws_cloudfront_distribution.s3_distribution.domain_name
    }