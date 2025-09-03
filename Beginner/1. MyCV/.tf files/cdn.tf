// CloudFront OAC definition:
    resource "aws_cloudfront_origin_access_control" "OAC_S3_hosting" {
        name = "OAC_s3_hosting (myCV)"
        description = "OAC for S3 static website hosting"
        origin_access_control_origin_type = "s3"
        // Determining whether requests are signed (always, never and no-override):
            signing_behavior = "always"
            signing_protocol = "sigv4"
    }

// CloudFront distr definition:
    resource "aws_cloudfront_distribution" "s3_distribution" {
    origin {
        domain_name              = aws_s3_bucket.valeroku_mycv.bucket_regional_domain_name
        origin_access_control_id = aws_cloudfront_origin_access_control.OAC_S3_hosting.id
        origin_id                = aws_s3_bucket.valeroku_mycv.id
        }

    enabled             = true
    is_ipv6_enabled     = true
    comment             = "CDN for static website"
    default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = aws_s3_bucket.valeroku_mycv.id

    // OPTIONAL
        forwarded_values {
        query_string = false
        cookies {
            forward = "none"
        }
        }

    // Default:
        viewer_protocol_policy = "redirect-to-https"
    }

    restrictions {
        geo_restriction {
        restriction_type =  "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }
}

