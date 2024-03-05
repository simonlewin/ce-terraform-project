# Servers
resource "aws_instance" "lighting" {

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.public_security_group_ids
  key_name               = var.key_name
  subnet_id              = var.public_subnet_ids[0]

  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-lighting"
  }
}

resource "aws_instance" "heating" {

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.public_security_group_ids
  key_name               = var.key_name
  subnet_id              = var.public_subnet_ids[1]

  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-heating"
  }
}

resource "aws_instance" "status" {

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.public_security_group_ids
  key_name               = var.key_name
  subnet_id              = var.public_subnet_ids[2]

  associate_public_ip_address = true

  tags = {
    Name = "${var.name}-status"
  }
}

resource "aws_instance" "auth" {

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.private_security_group_ids
  key_name               = var.key_name
  subnet_id              = var.private_subnet_ids[0]

  tags = {
    Name = "${var.name}-auth"
  }
}
