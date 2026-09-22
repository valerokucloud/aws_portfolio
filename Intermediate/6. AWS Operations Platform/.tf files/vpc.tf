# AZ zones definition + networking:
  data "aws_availability_zones" "available" {
    state = "available"
  }

  resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
      Name = "${var.project_name}-vpc"
    }
  }

  resource "aws_subnet" "public_a" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-public-a"
    }
  }

  resource "aws_subnet" "public_b" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.2.0/24"
    availability_zone       = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.project_name}-public-b"
    }
  }

  # IGW + Route table:
  resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
      Name = "${var.project_name}-igw"
    }
  }

  resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.main.id
    }

    tags = {
      Name = "${var.project_name}-public-rt"
    }
  }

  resource "aws_route_table_association" "public_a" {
    subnet_id      = aws_subnet.public_a.id
    route_table_id = aws_route_table.public.id
  }

  resource "aws_route_table_association" "public_b" {
    subnet_id      = aws_subnet.public_b.id
    route_table_id = aws_route_table.public.id
}