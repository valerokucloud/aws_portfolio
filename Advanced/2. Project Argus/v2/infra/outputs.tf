output "bucket_name" {
  value = aws_s3_bucket.images.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.images.arn
}

output "camera_access_key_id" {
  value = aws_iam_access_key.camera.id
}

output "camera_secret_access_key" {
  value     = aws_iam_access_key.camera.secret
  sensitive = true
}

output "sns_topic_arn" {
  value = aws_sns_topic.argus_alerts.arn
}