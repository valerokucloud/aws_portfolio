# ALB DNS value:
    output "alb_dns" {
        value = aws_lb.app.dns_name
}