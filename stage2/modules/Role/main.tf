resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "app-ecs-ecsTaskExecutionRole-${var.workspace}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}
