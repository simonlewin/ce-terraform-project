# Security group to allow HTTP
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound and outbound traffic"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-sg"
  }
}

# VPC security group ingress rule - port 80
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80

  tags = {
    Name = "${var.name}-ingress-rule"
  }
}

# VPC security group ingress rule - port 3000
resource "aws_vpc_security_group_ingress_rule" "allow_port" {
  security_group_id = aws_security_group.allow_http.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 3000
  ip_protocol = "tcp"
  to_port     = 3000

  tags = {
    Name = "${var.name}-ingress-rule"
  }
}

# VPC security group egress rule
resource "aws_vpc_security_group_egress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_http.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80

  tags = {
    Name = "${var.name}-egress-rule"
  }
}

# Security group to allow HTTPS
resource "aws_security_group" "allow_https" {
  name        = "allow_https"
  description = "Allow HTTPS inbound and outbound traffic"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-sg"
  }
}

# VPC security group ingress rule
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_https.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443

  tags = {
    Name = "${var.name}-ingress-rule"
  }
}

# VPC security group egress rule
resource "aws_vpc_security_group_egress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_https.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443

  tags = {
    Name = "${var.name}-egress-rule"
  }
}

# Security group to allow SSH
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic only from my ip address"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-sg"
  }
}

# HTTP data resource to get my IP address
data "http" "my_ip_address" {
  url = "http://ipv4.icanhazip.com"
}

# VPC security group ingress rule
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_ssh.id

  cidr_ipv4   = "${chomp(data.http.my_ip_address.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22

  tags = {
    Name = "${var.name}-ingress-rule"
  }
}

# Security group to allow local traffic
resource "aws_security_group" "allow_local" {
  name        = "allow_local"
  description = "Allow all local inbound and outbound traffic"

  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ingress" {
  security_group_id = aws_security_group.allow_local.id

  cidr_ipv4   = "10.0.0.0/20"
  ip_protocol = "-1"

  tags = {
    Name = "${var.name}-ingress-rule"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_egress" {
  security_group_id = aws_security_group.allow_local.id

  cidr_ipv4   = "10.0.0.0/20"
  ip_protocol = "-1"

  tags = {
    Name = "${var.name}-egress-rule"
  }
}
