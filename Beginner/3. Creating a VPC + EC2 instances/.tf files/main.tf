resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  # OPT - Enabling DNS (support and hostname visibility):
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "main_vpc"
    }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "private subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Main IGW"
  }
}

# Public subnet routing declaration through IGW (for Internet access):
  resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
        }
    tags = {
      Name = "public route table"
        }
  }

# NAT GW + Elastic IP definition (for private subnet internet access):
  resource "aws_eip" "nat" {
    domain = "vpc"
  }

  resource "aws_nat_gateway" "natgw" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.private.id
    tags = {
      Name = "NAT GW"
    }
    # To ensure proper ordering, it is recommended to add an explicit dependency
    # on the Internet Gateway for the VPC.
      depends_on = [ aws_internet_gateway.igw ]
  }


# Private subnet declaration with IGW (for Internet access):
  resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.natgw.id
    }
    tags = {
      Name = "private route table"
    }
  }


# Route table association:
  resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  }

  resource "aws_route_table_association" "private" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.private.id
  }