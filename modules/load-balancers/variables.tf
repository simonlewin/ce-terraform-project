# Public Load Balancer Target Groups
variable "target_groups" {
  type        = list(string)
  description = "A list of names of the target groups"
}

variable "target_port" {
  type        = number
  description = "Port on which targets receive traffic"
}

variable "target_protocol" {
  type        = string
  description = "Protocol to use for routing traffic to the targets"
}

variable "vpc_id" {
  type        = string
  description = "Identifier of the VPC in which to create the target group"
}

# Public Load Balancer
variable "public_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the LB"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the LB"
}

variable "name" {
  type        = string
  description = "The value of the Name tag"
}

# Public Load Balancer Listener
variable "port" {
  type        = string
  description = "Port on which the load balancer is listening"
}

# Internal Load Balancer Target Groups
variable "int_target_groups" {
  type        = list(string)
  description = "A list of names of the internal target groups"
}

# Private Load Balancer
variable "private_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the LB"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to attach to the LB"
}
