# Bucket creation:
  resource "aws_s3_bucket" "example" {
    bucket = "valeroku-data-quicksight"
    tags = {
      Name = "S3 bucket for Quicksight"
    }
  }

# "Listeners.csv" upload:
  resource "aws_s3_object" "fichero" {
    bucket = aws_s3_bucket.example.bucket
    key = "/listeners.csv"                              # Source inside the bucket
    source = "${path.module}/s3_upload/listeners.csv"   # Local directory source
  }

# Generate manifest' content dynamically
  locals {
    manifest_content = templatefile("${path.module}/s3_upload/listeners.json.tpl", {
      bucket_name = aws_s3_bucket.example.bucket
      })
  }

# Uploading the manifest' file to the bucket:
  resource "aws_s3_object" "manifest_file" {
    bucket = aws_s3_bucket.example.bucket
    key = "/listeners.json"
    content = local.manifest_content
    content_type = "application/json"
  }