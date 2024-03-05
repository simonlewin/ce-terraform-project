# VPC
module "vpc" {
  source = "./modules/vpc"

  cidr_block = var.cidr_block
  name       = var.name

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

# Security
module "security" {
  source = "./modules/security"

  vpc_id = module.vpc.vpc_id
  name   = var.name
}

# DynamoDB
module "dynamodb" {
  source = "./modules/dynamo"

  name = var.name

  db_tables = var.db_tables
  hash_key  = var.hash_key
  type      = var.type
}

# Servers
module "servers" {
  source = "./modules/servers"

  name = var.name

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  private_security_group_ids = module.security.private_security_group_ids
  public_security_group_ids  = module.security.public_security_group_ids
  private_subnet_ids         = module.vpc.private_subnet_ids
  public_subnet_ids          = module.vpc.public_subnet_ids
}
