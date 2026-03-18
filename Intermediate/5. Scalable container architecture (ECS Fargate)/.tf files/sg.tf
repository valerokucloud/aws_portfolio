# ALB SG creation + IN/OUT rules:
  resource "aws_security_group" "alb" {
    name = "sg_alb"
    vpc_id = aws_vpc.main.id
    description = "Allow web traffic to ALB"
  }

  # Ingress rule (allow Internet traffic to ALB):
    resource "aws_vpc_security_group_ingress_rule" "alb_http" {
      security_group_id = aws_security_group.alb.id
      from_port = 80
      to_port = 80
      ip_protocol = "tcp"
      cidr_ipv4 = "0.0.0.0/0"
  }

  # Egress rule (allow ALB to send traffic outside):
    resource "aws_vpc_security_group_egress_rule" "alb_out" {
      security_group_id = aws_security_group.alb.id
      ip_protocol = "-1"    # ALL protocols (TCP, UDP, ICMP...)
      cidr_ipv4 = "0.0.0.0/0"
}


# ECS SG creation + IN/OUT rules:
  resource "aws_security_group" "ecs" {
      name = "sg_ecs"
      vpc_id = aws_vpc.main.id
  }

  resource "aws_vpc_security_group_ingress_rule" "ecs_from_alb" {
      security_group_id = aws_security_group.ecs.id
      referenced_security_group_id = aws_security_group.alb.id
      
      from_port = 80
      to_port = 80
      ip_protocol = "tcp"
      
  }

  resource "aws_vpc_security_group_egress_rule" "ecs_out" {
      security_group_id = aws_security_group.ecs.id
      ip_protocol = "-1"    # ALL protocols (TCP, UDP, ICMP...)
      cidr_ipv4 = "0.0.0.0/0" 
}

# SG RDS (only from ECS):
  resource "aws_security_group" "rds" {
    name = "Security Group for RDS DB"
    vpc_id = aws_vpc.main.id
}

# Access rule ECS --> RDS
  resource "aws_vpc_security_group_ingress_rule" "rds_from_ecs" {
    
    security_group_id = aws_security_group.rds.id
    referenced_security_group_id = aws_security_group.ecs.id

    from_port = 5432
    to_port = 5432
    ip_protocol = "tcp"
  }