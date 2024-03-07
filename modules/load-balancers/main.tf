# Load Balancer Target Groups
resource "aws_lb_target_group" "lb_tg" {
  count = length(var.target_groups) - 1

  name     = var.target_groups[count.index]
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = "/api/${var.target_groups[count.index]}/health"
    port = var.target_port
  }

  tags = {
    Name = "${var.name}-lb-tg-${var.target_groups[count.index]}"
  }
}

# Register instances with Load Balancer target groups
resource "aws_lb_target_group_attachment" "lb_tg_attach" {
  count            = length(var.target_groups) - 1
  target_group_arn = aws_lb_target_group.lb_tg[count.index].arn
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
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }

  tags = {
    Name = "${var.name}-public-lb-listener"
  }
}

# Public Load Balancer Listener Rules
resource "aws_lb_listener_rule" "path_based_routing" {
  count = length(var.target_groups) - 1

  listener_arn = aws_lb_listener.public_lb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg[count.index].arn
  }

  condition {
    path_pattern {
      values = ["/api/${var.target_groups[count.index]}*"]
    }
  }

  tags = {
    Name = "${var.name}-lb-listener-rule-${var.target_groups[count.index]}"
  }
}

# Internal Load Balancer Target Groups
resource "aws_lb_target_group" "int_lb_tg" {
  count = length(var.target_groups)

  name     = "${var.target_groups[count.index]}-int"
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpc_id

  health_check {
    path = var.target_groups[count.index] != "auth" ? "/api/${var.target_groups[count.index]}/health" : "/api/${var.target_groups[count.index]}"
    port = var.target_port
  }

  tags = {
    Name = "${var.name}-lb-tg-${var.target_groups[count.index]}-int"
  }
}

# Register instances with Load Balancer target groups
resource "aws_lb_target_group_attachment" "lb_tg_attach-int" {
  count            = length(var.target_groups)
  target_group_arn = aws_lb_target_group.int_lb_tg[count.index].arn
  target_id        = var.target_ids[count.index]
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
    target_group_arn = aws_lb_target_group.int_lb_tg[2].arn
  }

  tags = {
    Name = "${var.name}-private-lb-listener"
  }
}

# Private Load Balancer Listener Rules
resource "aws_lb_listener_rule" "int_path_based_routing" {
  count = length(var.target_groups)

  listener_arn = aws_lb_listener.private_lb_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.int_lb_tg[count.index].arn
  }

  condition {
    path_pattern {
      values = ["/api/${var.target_groups[count.index]}*"]
    }
  }

  tags = {
    Name = "${var.name}-int-lb-listener-rule-${var.target_groups[count.index]}"
  }
}
