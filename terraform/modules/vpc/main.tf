# Create VPC

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

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

  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }
}


# Create Private Subnet 1
resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subnet_cidr_private_1
    availability_zone = "data.aws_availability_zones.available.names[0]"
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project_name}-private-subnet-1"
    }
}


# Create Private Subnet 2 
resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.vpc.id     
    cidr_block = var.subnet_cidr_private_2
    availability_zone = "data.aws_availability_zones.available.names[1]"
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project_name}-private-subnet-2"
    }
}

# Create Private Subnet 3
resource "aws_subnet" "private_subnet_3" {
    vpc_id = aws_vpc.vpc.id     
    cidr_block = var.subnet_cidr_private_3
    availability_zone = "data.aws_availability_zones.available.names[2]"
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project_name}-private-subnet-3"
    }
}

# Create Private Subnet 4
resource "aws_subnet" "private_subnet_4" {
    vpc_id = aws_vpc.vpc.id     
    cidr_block = var.subnet_cidr_private_4
    availability_zone = "data.aws_availability_zones.available.names[3]"  
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project_name}-private-subnet-4"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id  
    tags = {
        Name = "${var.project_name}-igw"
    }
}    



# Create elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {  
    Name = "${var.project_name}-nat-eip"
  }
}


# Create NAT Gateway in public subnet 1
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_1.id
  tags = {
    Name = "${var.project_name}-nat-gw"    
  }  
}

# Create NAT Gateway in public subnet 2
resource "aws_nat_gateway" "nat_gw_2" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_2.id
  tags = {  
    Name = "${var.project_name}-nat-gw-2"    
  }     
}


# Create route table for public subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id   
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "${var.project_name}-public-rt"
    }
}


# Create route table for private subnet 1
resource "aws_route_table" "private_rt_1" {
  vpc_id = aws_vpc.vpc.id   
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }
    tags = {        
        Name = "${var.project_name}-private-rt"
    }   
}

# Create route table for private subnet 2
resource "aws_route_table" "private_rt_2" {
  vpc_id = aws_vpc.vpc.id   
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw_2.id
    }
    tags = {    
        Name = "${var.project_name}-private-rt-2"   
    }
}

# Associate public subnets with public route table
resource "aws_route_table_association" "public_subnet_1_assoc" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2_assoc" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}


# Associate private subnet 1 with private route table
resource "aws_route_table_association" "private_subnet_1_assoc" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt_1.id
}

# Associate private subnet 2 with private route table
resource "aws_route_table_association" "private_subnet_2_assoc" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt_2.id 
}