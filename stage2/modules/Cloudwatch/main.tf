# resource "aws_cloudwatch_log_group" "aws_cw_lg" {
#   name = "/ecs/${var.env_prefix}-task"
#   retention_in_days = "90"
#   tags = {
#     "Name" : "ecs-loggroup-${var.env_prefix}"
#   }
      

# }

// Cloudwatch for the high CPU and autoscaling trigger
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.env_prefix}-ecs-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = "${var.env_prefix}-service"
  }

  alarm_actions = [var.ecs_scale_up_arn]
}


// Cloudwatch for the low CPU and autoscaling trigger
resource "aws_cloudwatch_metric_alarm" "low_cpu" {
  alarm_name          = "${var.env_prefix}-ecs-low-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    ClusterName  = var.ecs_cluster_name
    ServiceName  = "${var.env_prefix}-service"
  }

  alarm_actions = [var.ecs_scale_down_arn]
}
