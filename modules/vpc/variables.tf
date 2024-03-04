# VPC
variable "cidr_block" {
  type = string
  description = "The IPv4 CIDR block for the VPC"
}

variable "name" {
  type = string
  description = "The value of the Name tag"
}