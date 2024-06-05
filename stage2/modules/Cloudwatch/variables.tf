variable env_prefix {}
variable ecs_scale_up_arn {}
variable ecs_scale_down_arn {}

variable ecs_cluster_name {
    description = "ECS cluster name"
    type = string
}


variable ecr_repo_name {
    description = "ECR repo name"
    type = string
}
