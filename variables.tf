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
