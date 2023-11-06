resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"
}

resource "aws_cloudwatch_log_group" "example-log-gr" {
  name = "example-log-gr"
}

resource "aws_cloudwatch_log_stream" "example-log-stream" {
  name           = "example-log-stream"
  log_group_name = aws_cloudwatch_log_group.example-log-gr.name
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-nodejs-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = 256
  memory                   = 1024

  container_definitions = jsonencode([
    {
      name   = "my-nodejs-api",
      image  = var.imageRepo,
      memory = 512,
      cpu    = 256,
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ],
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : aws_cloudwatch_log_group.example-log-gr.name
          awslogs-stream-prefix : "ecs",
          awslogs-region : "ap-southeast-1"
        },
      }
    }
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = "my-nodejs-api-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2
  network_configuration {
    subnets          = var.subnetIds
    security_groups  = [var.sgId]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = "my-nodejs-api"
    container_port   = 3000
  }
  depends_on = [aws_ecs_task_definition.my_task, aws_lb_target_group.my_target_group]
}