resource "aws_autoscaling_group" "autoscaling" {
  count = length(var.autoscaling_groups)

  name = var.autoscaling_groups[count.index]

  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  target_group_arns   = var.autoscaling_groups[count.index] != "auth" ? [var.target_group_arns[count.index], var.int_target_group_arns[count.index]] : [var.int_target_group_arns[count.index]]
  vpc_zone_identifier = [var.vpc_zone_identifiers[count.index]]

  launch_template {
    id = var.launch_templates[count.index]
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-${var.autoscaling_groups[count.index]}"
    propagate_at_launch = true
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}
