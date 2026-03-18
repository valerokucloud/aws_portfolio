# ALB creation:
  resource "aws_lb" "app" {
    load_balancer_type = "application"
    subnets = [aws_subnet.public_a.id,
                aws_subnet.public_b.id]
    security_groups = [aws_security_group.alb.id]
    #  Add CloudWatch' LB health logs in a S3 bucket through 'health_checks_logs'
}

# Target group creation:
  resource "aws_lb_target_group" "app" {
    name = "tg-ecs"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id
    target_type = "ip"
    health_check {
      path                = "/"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      matcher             = "200"
    }
}

# Listener creation:
  resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.app.arn

    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.app.arn
    }
}