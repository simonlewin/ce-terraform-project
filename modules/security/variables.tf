# Security Group
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "name" {
  type        = string
  description = "The value of the Name tag"
}