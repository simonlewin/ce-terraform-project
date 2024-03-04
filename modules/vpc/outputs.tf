# VPC
output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}

# Subnets
output "public_subnet_ids" {
  value       = aws_subnet.public_subnets[*].id
  description = "A list of ID of the public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnets[*].id
  description = "A list of ID of the private subnets"
}
