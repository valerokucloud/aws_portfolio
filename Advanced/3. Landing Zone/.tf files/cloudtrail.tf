# CloudTrail organization (with S3 bucket destination):
resource "aws_cloudtrail" "organization" {
  name = "Organization-trail"

  s3_bucket_name = aws_s3_bucket.cloudtrail_logs.id

  is_organization_trail = true
  is_multi_region_trail = true

  include_global_service_events = true

  enable_log_file_validation = true

  depends_on = [
    aws_s3_bucket_policy.cloudtrail_logs
  ]
}
