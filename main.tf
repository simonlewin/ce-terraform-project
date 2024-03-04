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
