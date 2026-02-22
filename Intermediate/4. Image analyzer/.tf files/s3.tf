# Bucket creation
  resource "aws_s3_bucket" "tf_image_rek" {
  bucket = "tf-image-rekognition"

  tags = {
      Project = "tf-image-rekognition"
      Service = "rekognition"
    }
}

# Public access block:
  resource "aws_s3_bucket_public_access_block" "images" {
    bucket = aws_s3_bucket.tf_image_rek.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}



