# Providers
variable "region" {
  type        = string
  description = "The AWS region"
}

# VPC
variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "name" {
  type        = string
  description = "The value of the Name tag"
}

# Subnets
variable "azs" {
  type        = list(string)
  description = "A list of Availability Zones for subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "A list of the CIDR blocks for the public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of the CIDR blocks for the private subnets"
}

# DynamoDB
variable "db_tables" {
  type        = list(string)
  description = "A list of the DynamoDB table names"
}

variable "hash_key" {
  type        = string
  description = "The attribute to use as the hash (partition) key"
}

variable "type" {
  type        = string
  description = "The attribute type"
}

# Servers
variable "ami" {
  type        = string
  description = "AMI to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance"
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub Access Token"
}

variable "ACCESS_KEY" {
  type        = string
  description = "DynamoDB Access Key"
}

variable "SECRET_ACCESS_KEY" {
  type        = string
  description = "DynamoDB Secret Access Key"
}

# Load Balancers
variable "services" {
  type        = list(string)
  description = "A list of the services"
}

variable "target_port" {
  type        = number
  description = "Port on which targets receive traffic"
}

variable "target_protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets"
}

variable "port" {
  type        = string
  description = "Port on which the load balancer is listening"
}

variable "int_services" {
  type        = list(string)
  description = "A list of the internal services"
}
