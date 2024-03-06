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

  user_data = <<-EOT
                #!/bin/bash
                cd /home/ubuntu
                git clone https://${var.GITHUB_TOKEN}@github.com/northcoders/ce-project-lights.git
                sudo chown -R ubuntu:ubuntu ce-project-lights/
                cd ce-project-lights
                echo -e "ACCESS_KEY=${var.ACCESS_KEY}\nSECRET_ACCESS_KEY=${var.SECRET_ACCESS_KEY}\nTABLE_NAME=lighting" > .env.local
                EOT
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

  user_data = <<-EOT
                #!/bin/bash
                cd /home/ubuntu
                git clone https://${var.GITHUB_TOKEN}@github.com/northcoders/ce-project-heating.git
                sudo chown -R ubuntu:ubuntu ce-project-heating/
                cd ce-project-heating
                echo -e "ACCESS_KEY=${var.ACCESS_KEY}\nSECRET_ACCESS_KEY=${var.SECRET_ACCESS_KEY}\nTABLE_NAME=heating" > .env.local
                EOT
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

  user_data = <<-EOT
                #!/bin/bash
                cd /home/ubuntu
                git clone https://${var.GITHUB_TOKEN}@github.com/northcoders/ce-project-status.git
                sudo chown -R ubuntu:ubuntu ce-project-status/
                cd ce-project-status
                echo -e "LIGHTS_SERVICE=${aws_instance.lighting.private_ip}\nHEATING_SERVICE=${aws_instance.heating.private_ip}\nAUTH_SERVICE=${aws_instance.auth.private_ip}" > .env.local
                EOT
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

  user_data = <<-EOT
                #!/bin/bash
                cd /home/ubuntu
                git clone https://${var.GITHUB_TOKEN}@github.com/northcoders/ce-smart-home-auth.git
                sudo chown -R ubuntu:ubuntu ce-smart-home-auth/
                cd ce-smart-home-auth
                EOT
}
