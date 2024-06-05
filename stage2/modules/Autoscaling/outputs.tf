output "as_scale_up" {
    value = aws_appautoscaling_policy.scale_up.arn
}

output "as_scale_down" {
    value = aws_appautoscaling_policy.scale_down.arn
}