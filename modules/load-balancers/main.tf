# Public Load Balancer Target Groups
resource "aws_lb_target_group" "public_lb_tg" {
  count = length(var.tg_names)

  name     = var.tg_names[count.index]
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = "/api/${var.tg_names[count.index]}/health"
    port = var.target_port
  }

  tags = {
    Name = "${var.name}-public-lb-tg-${var.tg_names[count.index]}"
  }
}

# Register instances with public ALB target groups
resource "aws_lb_target_group_attachment" "lb_tg_attachment" {
  count            = length(var.tg_names)
  target_group_arn = aws_lb_target_group.public_lb_tg[count.index].arn
  target_id        = var.target_ids[count.index]
  port             = var.target_port
}

# Public Load Balancer
resource "aws_lb" "public_lb" {
  name            = "public-lb"
  security_groups = var.public_security_group_ids
  subnets         = var.public_subnet_ids

  tags = {
    Name = "${var.name}-public-lb"
  }
}

# Public Load Balancer Listener
resource "aws_lb_listener" "public_lb_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = var.port

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_lb_tg[2].arn
  }

  tags = {
    Name = "${var.name}-public-lb-listener"
  }
}

# Public Load Balancer Listener Rules
resource "aws_lb_listener_rule" "paths" {
  count = length(var.tg_names)

  listener_arn = aws_lb_listener.public_lb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_lb_tg[count.index].arn
  }

  condition {
    path_pattern {
      values = ["/api/${var.tg_names[count.index]}*"]
    }
  }

  tags = {
    Name = "${var.name}-lb-listener-rule-${var.tg_names[count.index]}"
  }
}

# Private Load Balancer Target Groups
resource "aws_lb_target_group" "private_lb_tg" {
  count = length(var.int_tg_names)

  name     = "private-${var.int_tg_names[count.index]}"
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = var.int_tg_names[count.index] != "auth" ? "/api/${var.int_tg_names[count.index]}/health" : "/api/${var.int_tg_names[count.index]}"
    port = var.target_port
  }

  tags = {
    Name = "${var.name}-private-lb-tg-${var.int_tg_names[count.index]}"
  }
}

# Register instances with private ALB target groups
resource "aws_lb_target_group_attachment" "int_lb_tg_attachment" {
  count            = length(var.int_tg_names)
  target_group_arn = aws_lb_target_group.private_lb_tg[count.index].arn
  target_id        = var.int_target_ids[count.index]
  port             = var.target_port
}

# Private internal load balancer
resource "aws_lb" "private_lb" {
  name     = "private-lb"
  internal = true

  security_groups = var.private_security_group_ids
  subnets         = var.private_subnet_ids

  tags = {
    Name = "${var.name}-private-lb"
  }
}

# Internal Load Balancer Listener
resource "aws_lb_listener" "private_lb_listener" {
  load_balancer_arn = aws_lb.private_lb.arn
  port              = var.port

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_lb_tg[2].arn
  }

  tags = {
    Name = "${var.name}-private-lb-listener"
  }
}

# Private Load Balancer Listener Rules
resource "aws_lb_listener_rule" "internal_paths" {
  count = length(var.int_tg_names)

  listener_arn = aws_lb_listener.private_lb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_lb_tg[count.index].arn
  }

  condition {
    path_pattern {
      values = ["/api/${var.int_tg_names[count.index]}*"]
    }
  }

  tags = {
    Name = "${var.name}-int-lb-listener-rule-${var.int_tg_names[count.index]}"
  }
}
