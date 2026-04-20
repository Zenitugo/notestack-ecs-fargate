
# Create an Application Load Balancer (ALB) 
resource "aws_lb" "notestack_lb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.public_subnet_1_id, var.public_subnet_2_id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "notestack_tg" {
  name     = "${var.project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

    health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
    }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.notestack_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notestack_tg.arn
  }
}


# Create an Application Load Balancer for the backend service
resource "aws_lb" "notestack_backend_lb" {
  name               = "${var.project_name}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.ecs_sg_backend_id]
  subnets            = [var.private_subnet_1_id, var.private_subnet_2_id]
}

resource aws_lb_target_group "notestack_backend_tg" {
  name     = "${var.project_name}-backend-tg"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

    health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 30
    }
}

resource "aws_lb_listener" "backend_http" {
  load_balancer_arn = aws_lb.notestack_backend_lb.arn
  port              = var.backend_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.notestack_backend_tg.arn
  }
}