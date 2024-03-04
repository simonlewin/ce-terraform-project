variable "name" {
  type        = string
  description = "The value of the Name tag"
}

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
