# Cert creation (has to be in "us-east-1". MANDATORY)
    resource "aws_acm_certificate" "cert_mydomain" {
      region = "us-east-1"
      domain_name = "theBestCV.com"
      validation_method = "DNS"
      subject_alternative_names = ["www.theBestCV.com"]
    }

# Cert validation:
    resource "aws_acm_certificate_validation" "cert_val" {
      region = "us-east-1"
      certificate_arn = aws_acm_certificate.cert_mydomain.arn
      validation_record_fqdns = [for record in aws_route53_record.cloudf_acm : record.fqdn] 
      depends_on = [ 
        aws_acm_certificate.cert_mydomain,
        aws_route53_record.cloudf_acm
      ]
    }