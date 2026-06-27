# R53 DNS automatic registration:
    resource "aws_route53_record" "cert_validation" {
    for_each = {
        for dvo in aws_acm_certificate.portfolio.domain_validation_options :
        dvo.domain_name => {
        name   = dvo.resource_record_name
        record = dvo.resource_record_value
        type   = dvo.resource_record_type
        }
    }

    zone_id = "Z01854032GTDES9Y32GXM"
    name    = each.value.name
    type    = each.value.type
    ttl     = 60
    records = [each.value.record]
}

# Root domain -> CloudFront
    resource "aws_route53_record" "frontend_root" {

    zone_id = "Z01854032GTDES9Y32GXM"
    name    = "['YOUR_DOMAIN']"
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.frontend.domain_name
        zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
        evaluate_target_health = false
    }
}

# WWW -> CloudFront
    resource "aws_route53_record" "frontend_www" {

    zone_id = "Z01854032GTDES9Y32GXM"
    name    = "www.['YOUR_DOMAIN']"
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.frontend.domain_name
        zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
        evaluate_target_health = false
    }
}
