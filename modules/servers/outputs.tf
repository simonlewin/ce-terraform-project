output "lighting_id" {
  value       = aws_instance.lighting.id
  description = "ID of the instance"
}

output "heating_id" {
  value       = aws_instance.heating.id
  description = "ID of the instance"
}

output "status_id" {
  value       = aws_instance.status.id
  description = "ID of the instance"
}

output "auth_id" {
  value       = aws_instance.auth.id
  description = "ID of the instance"
}
