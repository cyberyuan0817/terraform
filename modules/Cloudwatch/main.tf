resource "aws_cloudwatch_log_group" "aws_cw_lg" {
  name = "/ecs/${var.env_prefix}-task"
  retention_in_days = "90"
  tags = {
    "Name" : "ecs-loggroup-${var.env_prefix}"
  }
      

}