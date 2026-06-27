# CloudFront OAC:
    resource "aws_cloudfront_origin_access_control" "oac" {
    name                              = "portfolio-oac"
    description                       = "OAC for portfolio bucket"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "always"
    signing_protocol                  = "sigv4"
}

# CloudFront distr:
    resource "aws_cloudfront_distribution" "frontend" {

  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id   = "portfolio-s3-origin"
    origin_access_control_id=aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD"
    ]
    cached_methods = [
      "GET",
      "HEAD"
    ]
    target_origin_id = "portfolio-s3-origin"

    viewer_protocol_policy = "redirect-to-https"
    compress = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }

    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.portfolio.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = [
  "['YOUR_DOMAIN'].xxx",
  "www.['YOUR_DOMAIN'].xxx"
]
}