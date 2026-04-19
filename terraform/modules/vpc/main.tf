# Create VPC

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "${var.project_name}-vpc"
  }
}


# Create public subnet 1
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr_public_1
  availability_zone = "data.aws_availability_zones.available.names[0]"
  map_public_ip_on_launch = true
  dns_support = true
  dns_hostnames = true

  tags = {
    Name = "${var.project_name}-public-subnet-1"
  }
}


# Create public subnet 2
resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr_public_2
  availability_zone = "data.aws_availability_zones.available.names[1]"
  map_public_ip_on_launch = true
  dns_support = true
  dns_hostnames = true

  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }
}