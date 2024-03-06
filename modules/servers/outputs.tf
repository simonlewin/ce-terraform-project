output "service_ids" {
  value       = [aws_instance.lighting.id, aws_instance.heating.id, aws_instance.status.id]
  description = "A list of IDs of the instances"
}

output "auth_id" {
  value       = aws_instance.auth.id
  description = "ID of the instance"
}
