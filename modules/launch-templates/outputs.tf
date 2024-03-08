output "ids" {
  value       = aws_launch_template.launch_template[*].id
  description = "A list of the IDs of the launch templates"
}
