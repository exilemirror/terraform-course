# Internet VPC
resource "aws_vpc" "main-lab" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "vpc-main-lab"
  }
}

# Public Subnets
resource "aws_subnet" "main-lab-public-1" {
  vpc_id                  = aws_vpc.main-lab.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "sn-main-lab-public-1"
  }
}

resource "aws_subnet" "main-lab-public-2" {
  vpc_id                  = aws_vpc.main-lab.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "sn-main-lab-public-2"
  }
}

# Private Subnets
resource "aws_subnet" "main-lab-private-1" {
  vpc_id                  = aws_vpc.main-lab.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1a"

  tags = {
    Name = "sn-main-lab-private-1"
  }
}

resource "aws_subnet" "main-lab-private-2" {
  vpc_id                  = aws_vpc.main-lab.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-1b"

  tags = {
    Name = "sn-main-lab-private-2"
  }
}


# Internet GW
resource "aws_internet_gateway" "main-lab-gw" {
  vpc_id = aws_vpc.main-lab.id

  tags = {
    Name = "igw-main-lab"
  }
}

# route tables for public
resource "aws_route_table" "main-lab-public" {
  vpc_id = aws_vpc.main-lab.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-lab-gw.id
  }

  tags = {
    Name = "rt-main-lab-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-lab-public-1-a" {
  subnet_id      = aws_subnet.main-lab-public-1.id
  route_table_id = aws_route_table.main-lab-public.id
}

resource "aws_route_table_association" "main-lab-public-2-a" {
  subnet_id      = aws_subnet.main-lab-public-2.id
  route_table_id = aws_route_table.main-lab-public.id
}

