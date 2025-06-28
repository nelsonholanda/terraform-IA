# NH-TESTE ECS Task Definition (Fargate)
resource "aws_ecs_task_definition" "nh_teste" {
  family                   = "NH-TESTE"
  network_mode             = "awsvpc"  # Required for Fargate
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
  
  container_definitions = jsonencode([
    {
      name  = "nh-teste-container"
      image = "nginx:latest"
      
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      
      # Download HTML from S3 and start nginx
      command = [
        "/bin/sh",
        "-c",
        "aws s3 cp s3://${aws_s3_bucket.static_website.bucket}/index.html /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
      ]
      
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/NH-TESTE"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      
      essential = true
    }
  ])
  
  tags = merge(var.default_tags, {
    Name = "NH-TESTE-task-definition"
  })
}

# NH-TESTE ECS Service
resource "aws_ecs_service" "nh_teste" {
  name            = "NH-TESTE-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nh_teste.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  
  # Enable service discovery and auto scaling
  enable_execute_command = true
  
  network_configuration {
    subnets          = aws_subnet.public[*].id
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nh_teste.arn
    container_name   = "nh-teste-container"
    container_port   = 80
  }

  # Health check grace period for auto scaling
  health_check_grace_period_seconds = 60

  depends_on = [aws_lb_listener.http, aws_s3_object.index_html]
  
  tags = merge(var.default_tags, {
    Name = "NH-TESTE-service"
  })
}

# CloudWatch Log Group for NH-TESTE
resource "aws_cloudwatch_log_group" "nh_teste" {
  name              = "/ecs/NH-TESTE"
  retention_in_days = 7
  
  tags = merge(var.default_tags, {
    Name = "NH-TESTE-log-group"
  })
} 