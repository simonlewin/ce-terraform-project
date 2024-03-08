variable "autoscaling_groups" {
  type        = list(string)
  description = "A list of the auto scaling groups"
}

variable "desired_capacity" {
  type        = number
  description = "Number of Amazon EC2 instances that should be running in the group"
}

variable "launch_templates" {
  type        = list(string)
  description = "A list of IDs of the launch templates"
}

variable "max_size" {
  type        = number
  description = "Maximum size of the Auto Scaling Group"
}

variable "min_size" {
  type        = number
  description = "Minimum size of the Auto Scaling Group"
}

variable "vpc_zone_identifiers" {
  type        = list(string)
  description = "List of subnet IDs to launch resources in"
}

variable "target_group_arns" {
  type        = list(string)
  description = "List of target group ARNs, for use with Load Balancing"
}

variable "int_target_group_arns" {
  type        = list(string)
  description = "List of internal target group ARNs, for use with Load Balancing"
}

variable "name" {
  type        = string
  description = "The value of the Name tag"
}
