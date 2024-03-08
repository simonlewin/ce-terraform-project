# Launch Templates
variable "name" {
  type        = string
  description = "The value of the Name tag"
}

variable "image_ids" {
  type = list(object({
    name   = string
    ami_id = string
  }))
  description = "A list of the AMIs from which to launch the instances"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the instance"
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "private_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the LB"
}

variable "public_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to assign to the LB"
}
