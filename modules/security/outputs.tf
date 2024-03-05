output "security_group_ids" {
  value       = [aws_security_group.allow_http.id, aws_security_group.allow_https.id, aws_security_group.allow_ssh.id]
  description = "IDs of the security groups"
}
