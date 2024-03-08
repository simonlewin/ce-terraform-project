# Providers
region = "eu-west-2"

# VPC 
cidr_block = "10.0.0.0/20"
name       = "terraform-project"

# Subnets
azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
private_subnets = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
public_subnets  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]

# DynamoDB Tables
db_tables = ["lighting", "heating"]
type      = "N"
hash_key  = "id"

# Servers
ami           = "ami-0d18e50ca22537278"
instance_type = "t2.micro"
key_name      = "nc-photo-display-app"

# Load Balancers
target_groups     = ["lights", "heating", "status"]
int_target_groups = ["lights", "heating", "status", "auth"]
target_port       = 3000
target_protocol   = "HTTP"
port              = "80"

# Launch Templates
image_ids = [
  {
    name   = "lighting"
    ami_id = "ami-0fe352da0386aa5e4"
  },
  {
    name   = "heating"
    ami_id = "ami-07801dd25f586f23a"
  },
  {
    name   = "status"
    ami_id = "ami-056aacec5540a9b95"
  },
  {
    name   = "auth"
    ami_id = "ami-084bc5d7d555dc6d9"
  }
]

# Auto Scaling Groups
desired_capacity   = 2
max_size           = 4
min_size           = 1
