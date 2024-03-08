output "target_group_arns" {
  value       = aws_lb_target_group.lb_tg[*].arn
  description = "A list of ARNs of the Target Groups"
}

output "int_target_group_arns" {
  value       = aws_lb_target_group.int_lb_tg[*].arn
  description = "A list of ARNs of the internal Target Groups"
}
