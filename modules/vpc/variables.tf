# VPC
variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "name" {
  type        = string
  description = "The value of the Name tag"
}

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
