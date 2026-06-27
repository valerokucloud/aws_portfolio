# ACM certificate creation (us-east-1 always):
    resource "aws_acm_certificate" "portfolio" {
        provider = aws.virginia
        domain_name = ['YOUR_DOMAIN'].xxx

        subject_alternative_names = ['YOUR_DOMAIN']
        validation_method = "DNS"
}

# ACM certificate validation with R53:
    resource "aws_acm_certificate_validation" "portfolio" {

    provider = aws.virginia

    certificate_arn = aws_acm_certificate.portfolio.arn

    validation_record_fqdns = [
        for record in aws_route53_record.cert_validation :
        record.fqdn
    ]
}