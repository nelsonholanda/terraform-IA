# Auto Scaling Target for ECS Service
resource "aws_appautoscaling_target" "nh_teste" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.nh_teste.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [
    aws_ecs_service.nh_teste,
    aws_ecs_cluster_capacity_providers.main
  ]
}

# Single Target Tracking Scaling Policy - Manages both scale up and scale down
resource "aws_appautoscaling_policy" "nh_teste_cpu_tracking" {
  name               = "nh-teste-cpu-tracking"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.nh_teste.resource_id
  scalable_dimension = aws_appautoscaling_target.nh_teste.scalable_dimension
  service_namespace  = aws_appautoscaling_target.nh_teste.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value       = 7.5  # Target CPU utilization
    scale_in_cooldown  = 120  # 2 minutes
    scale_out_cooldown = 30   # 30 seconds
    disable_scale_in   = false
  }

  depends_on = [aws_appautoscaling_target.nh_teste]
}

# CloudWatch Alarm for High CPU (Monitoring only)
resource "aws_cloudwatch_metric_alarm" "nh_teste_cpu_high" {
  alarm_name          = "nh-teste-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  alarm_description   = "This metric monitors ECS CPU utilization for monitoring"
  alarm_actions       = []

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.nh_teste.name
  }

  tags = merge(var.default_tags, {
    Name = "nh-teste-cpu-high-alarm"
  })
}

# CloudWatch Alarm for Low CPU (Monitoring only)
resource "aws_cloudwatch_metric_alarm" "nh_teste_cpu_low" {
  alarm_name          = "nh-teste-cpu-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "5"
  alarm_description   = "This metric monitors ECS CPU utilization for monitoring"
  alarm_actions       = []

  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.nh_teste.name
  }

  tags = merge(var.default_tags, {
    Name = "nh-teste-cpu-low-alarm"
  })
} 