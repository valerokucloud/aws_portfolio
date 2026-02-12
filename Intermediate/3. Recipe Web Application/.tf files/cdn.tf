
// S3 CloudFrontOAI:
resource "aws_cloudfront_origin_access_identity" "s3_OAI" {
  comment = "OAI for CloudFront S3 recipes frontend"
}

// CloudFront distr:
resource "aws_cloudfront_distribution" "CDN_recipes" {
  enabled             = true
  comment             = "Terraform Recipes CloudFront Distribution"
  default_root_object = "index.html"

  # -------- ORIGIN (S3) --------
  origin {
    domain_name = aws_s3_bucket.tf_chapter4_s3.bucket_regional_domain_name
    origin_id   = "s3-recipes-origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_OAI.cloudfront_access_identity_path
    }
  }

  # -------- CACHE BEHAVIOR --------
  default_cache_behavior {
    target_origin_id       = "s3-recipes-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  # -------- RESTRICTIONS --------
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # -------- CERTIFICATE --------
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Project = "tf_chapter4"
    Service = "recipes"
  }
}
