output "ids" {
  value       = aws_autoscaling_group.autoscaling[*]
  description = "A list of the IDs of the Auto Scaling Groups"
}
