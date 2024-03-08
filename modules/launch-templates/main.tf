resource "aws_launch_template" "launch_template" {
  count = length(var.image_ids)

  name = "${var.name}-${var.image_ids[count.index].name}"

  image_id      = var.image_ids[count.index].ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = var.image_ids[count.index].name == "auth" ? false : true
    security_groups             = var.image_ids[count.index].name == "auth" ? var.private_security_group_ids : var.public_security_group_ids
  }

  tags = {
    Name = "${var.name}-${var.image_ids[count.index].name}-template"
  }
}
