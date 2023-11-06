resource "aws_security_group" "alb_sg" {
  name   = "alb-public-sg"
  vpc_id = var.vpcId
  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "task_sg" {
  name   = "ecs-task-sg"
  vpc_id = var.vpcId
  ingress {
    from_port       = 3000
    protocol        = "tcp"
    to_port         = 3000
    security_groups = [aws_security_group.alb_sg.id]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}