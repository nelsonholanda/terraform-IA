# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidrs" {
  description = "CIDR blocks of the public subnets"
  value       = aws_subnet.public[*].cidr_block
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

# Security Group Outputs
output "ecs_tasks_security_group_id" {
  description = "ID of the ECS tasks security group"
  value       = aws_security_group.ecs_tasks.id
}

output "ecs_tasks_security_group_name" {
  description = "Name of the ECS tasks security group"
  value       = aws_security_group.ecs_tasks.name
}

# ECS Outputs
output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.main.id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.main.arn
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution.name
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.ecs_task.arn
}

output "ecs_task_role_name" {
  description = "Name of the ECS task role"
  value       = aws_iam_role.ecs_task.name
}

# NH-TESTE Outputs
output "nh_teste_task_definition_arn" {
  description = "ARN of the NH-TESTE task definition"
  value       = aws_ecs_task_definition.nh_teste.arn
}

output "nh_teste_task_definition_family" {
  description = "Family of the NH-TESTE task definition"
  value       = aws_ecs_task_definition.nh_teste.family
}

output "nh_teste_service_name" {
  description = "Name of the NH-TESTE service"
  value       = aws_ecs_service.nh_teste.name
}

output "nh_teste_service_cluster" {
  description = "Cluster of the NH-TESTE service"
  value       = aws_ecs_service.nh_teste.cluster
}

# CloudWatch Log Group Outputs
output "nh_teste_log_group_name" {
  description = "Name of the NH-TESTE CloudWatch log group"
  value       = aws_cloudwatch_log_group.nh_teste.name
}

# Load Balancer Outputs
output "alb_id" {
  description = "ID of the Application Load Balancer"
  value       = aws_lb.main.id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}

output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

# Target Group Outputs
output "nh_teste_target_group_arn" {
  description = "ARN of the NH-TESTE target group"
  value       = aws_lb_target_group.nh_teste.arn
}

output "nh_teste_target_group_name" {
  description = "Name of the NH-TESTE target group"
  value       = aws_lb_target_group.nh_teste.name
}

# Listener Outputs
output "alb_listener_arn" {
  description = "ARN of the ALB HTTP listener"
  value       = aws_lb_listener.http.arn
}

# Application URL
output "application_url" {
  description = "URL to access the NH-TESTE application"
  value       = "http://${aws_lb.main.dns_name}"
}

# Auto Scaling Outputs
output "autoscaling_target_id" {
  description = "ID of the Auto Scaling target"
  value       = aws_appautoscaling_target.nh_teste.id
}

output "autoscaling_target_resource_id" {
  description = "Resource ID of the Auto Scaling target"
  value       = aws_appautoscaling_target.nh_teste.resource_id
}

output "autoscaling_target_min_capacity" {
  description = "Minimum capacity of the Auto Scaling target"
  value       = aws_appautoscaling_target.nh_teste.min_capacity
}

output "autoscaling_target_max_capacity" {
  description = "Maximum capacity of the Auto Scaling target"
  value       = aws_appautoscaling_target.nh_teste.max_capacity
}

output "cpu_tracking_policy_arn" {
  description = "ARN of the CPU tracking policy"
  value       = aws_appautoscaling_policy.nh_teste_cpu_tracking.arn
}

# CloudWatch Alarms Outputs
output "cpu_high_alarm_arn" {
  description = "ARN of the high CPU alarm"
  value       = aws_cloudwatch_metric_alarm.nh_teste_cpu_high.arn
}

output "cpu_low_alarm_arn" {
  description = "ARN of the low CPU alarm"
  value       = aws_cloudwatch_metric_alarm.nh_teste_cpu_low.arn
} 