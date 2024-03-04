# Providers
region = "eu-west-2"

# VPC 
cidr_block = "10.0.0.0/20"
name       = "terraform-project"

# Subnets
azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
private_subnets = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
public_subnets  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
