# Servers
variable "name" {
  type        = string
  description = "The value of the Name tag"
}

variable "ami" {
  type        = string
  description = "AMI to use for the instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance"
}

variable "public_security_group_ids" {
  type        = list(string)
  description = "List of public security group IDs to associate with."
}

variable "private_security_group_ids" {
  type        = list(string)
  description = "List of private security group IDs to associate with."
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "(Public) VPC Subnet IDs to launch in"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "(Private) VPC Subnet IDs to launch in"
}
