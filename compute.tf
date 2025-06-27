# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "nh-ecs"
  
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  # Configuration for auto scaling
  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }
  
  tags = merge(var.default_tags, {
    Name = "nh-ecs"
  })
}

# ECS Cluster Capacity Providers (for auto scaling)
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
} 