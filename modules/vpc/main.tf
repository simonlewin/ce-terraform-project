# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

# Subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.public_subnets[count.index]

  tags = {
    Name = format("${var.name}-public-%s", element(var.azs, count.index))
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_subnets[count.index]

  tags = {
    Name = format("${var.name}-private-%s", element(var.azs, count.index))
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# Public Routing Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name}-public-rt"
  }
}

# Association between public route table and public subnets
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

# Elastic IP
resource "aws_eip" "eip" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.name}-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.name}-natgw"
  }

  depends_on = [aws_internet_gateway.igw]
}

# Private Routing Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "${var.name}-private-rt"
  }
}

# Association between private route table and private subnets
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private.id
}
