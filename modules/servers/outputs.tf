output "instance_ids" {
  value       = [aws_instance.lighting.id, aws_instance.heating.id, aws_instance.status.id, aws_instance.auth.id]
  description = "A list of IDs of the instances"
}
