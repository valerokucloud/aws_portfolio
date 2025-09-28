locals {
  my_domain    = "theBestCV.com"
}

# R53 record for the CloudFront distr aliases:
    data "aws_route53_zone" "my_domain" {
    name = local.my_domain
    private_zone = false
    }

    resource "aws_route53_record" "alias" {
       for_each = aws_cloudfront_distribution.s3_distribution.aliases
       zone_id  = data.aws_route53_zone.my_domain.zone_id
       name     = each.value
       type     = "A"

    alias {
        name                   = aws_cloudfront_distribution.s3_distribution.domain_name
        zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
        evaluate_target_health = false
        }
    }

    resource "aws_route53_record" "alias_www" {
        zone_id = data.aws_route53_zone.my_domain.zone_id
        name    = "www.theBestCV.com"
        type    = "A"

        alias {
            name                   = aws_cloudfront_distribution.s3_distribution.domain_name
            zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
            evaluate_target_health = false
        }
    }

# R53 record for the ACM integration:
    resource "aws_route53_record" "cloudf_acm" {
      for_each = {
        for dvo in aws_acm_certificate.cert_mydomain.domain_validation_options : dvo.domain_name => {
            name   = dvo.resource_record_name
            type   = dvo.resource_record_type
            record = dvo.resource_record_value
            
        }
      }
        zone_id         = data.aws_route53_zone.my_domain.zone_id
        allow_overwrite = true
        name            = each.value.name
        records         = [each.value.record]
        ttl             = 60
        type            = each.value.type
    }

