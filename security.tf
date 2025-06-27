# Security Group for ECS Tasks (Fargate)
resource "aws_security_group" "ecs_tasks" {
  name        = "nh-ecs-tasks-sg"
  description = "Security group for ECS tasks in Fargate"
  vpc_id      = aws_vpc.main.id
  
  # HTTP access from ALB only
  ingress {
    description     = "HTTP from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  
  # All outbound traffic (needed for tasks to access internet)
  egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(var.default_tags, {
    Name = "nh-ecs-tasks-sg"
  })
} 