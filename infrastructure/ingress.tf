resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnetIds
  security_groups    = [aws_security_group.alb_sg.id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpcId
  health_check {
    path                = "/health"
    port                = 3000
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = 200
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}