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

# Load Balancers
module "load_balancers" {
  source = "./modules/load-balancers"

  target_groups     = var.target_groups
  int_target_groups = var.int_target_groups
  target_port       = var.target_port
  target_protocol   = var.target_protocol
  vpc_id            = module.vpc.vpc_id

  public_security_group_ids = module.security.public_security_group_ids
  public_subnet_ids         = module.vpc.public_subnet_ids
  name                      = var.name

  port = var.port

  private_security_group_ids = module.security.private_security_group_ids
  private_subnet_ids         = module.vpc.private_subnet_ids
}

# Launch Template
module "launch_templates" {
  source = "./modules/launch-templates"

  name = var.name

  image_ids     = var.image_ids
  instance_type = var.instance_type
  key_name      = var.key_name

  public_security_group_ids  = module.security.public_security_group_ids
  private_security_group_ids = module.security.private_security_group_ids
}

# Auto Scaling
module "autoscaling" {
  source = "./modules/autoscaling"

  name = var.name

  autoscaling_groups = var.int_target_groups

  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  target_group_arns     = module.load_balancers.target_group_arns
  int_target_group_arns = module.load_balancers.int_target_group_arns

  vpc_zone_identifiers = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)

  launch_templates = module.launch_templates.ids
}
