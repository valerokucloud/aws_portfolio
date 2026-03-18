# VPC creation:
    resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
}

# Subnetting (public/private). Remember that ALB & RDS require 2 subnets in 2 different AZs:
  resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.main.id
    availability_zone = "eu-south-2a"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true    # Automated public IP
  }

  resource "aws_subnet" "public_b" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "eu-south-2b"
    map_public_ip_on_launch = true      # Automated public IP
  }

  resource "aws_subnet" "private_a" {
    vpc_id = aws_vpc.main.id
    availability_zone = "eu-south-2a"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = false   # Non-automated public IP
  }

  resource "aws_subnet" "private_b" {
    vpc_id = aws_vpc.main.id
    availability_zone = "eu-south-2b"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false   # Non-automated public IP
}

# IGW + Public routing:
  resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
  }

  resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
  }

  resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0" # ALL 
    gateway_id = aws_internet_gateway.igw.id
  }

  resource "aws_route_table_association" "public_a" {
    subnet_id = aws_subnet.public_a.id
    route_table_id = aws_route_table.public.id
  }

  resource "aws_route_table_association" "public_b" {
    subnet_id = aws_subnet.public_b.id
    route_table_id = aws_route_table.public.id
}

# NAT GW + Private routing:
    # Elastic IP creation:
    resource "aws_eip" "nat" {
      domain = "vpc"
    }

    resource "aws_nat_gateway" "nat" {
      allocation_id = aws_eip.nat.id
      subnet_id = aws_subnet.public_a.id
    }

    resource "aws_route_table" "private" {
      vpc_id = aws_vpc.main.id
    }

    resource "aws_route" "private_route" {
      route_table_id = aws_route_table.private.id
      destination_cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat.id
    }

    resource "aws_route_table_association" "private_a" {
      subnet_id = aws_subnet.private_a.id
      route_table_id = aws_route_table.private.id
    }

    resource "aws_route_table_association" "private_b" {
    subnet_id = aws_subnet.private_b.id
    route_table_id = aws_route_table.private.id
}

