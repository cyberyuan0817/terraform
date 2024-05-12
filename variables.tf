variable uat_vpc_cidr_block {}
variable prod_vpc_cidr_block {}

variable prod_public_subnet_names {
    type = list(string)
}
variable prod_public_subnet_cidr_block {
    type = list(string)
}
variable prod_private_subnet_names {
    type = list(string)
}
variable prod_private_subnet_cidr_block {
    type = list(string)
}
variable uat_subnet_names {
    type = list(string)
}
variable uat_subnet_cidr_block {
    type = list(string)
}
variable uat_avail_zone {
    type = list(string)
}
variable uat_env_prefix {}

variable uat_ecr_repo_name {
    description = "ECR repo name"
    type = string
}

variable uat_ecs_cluster_name {
    description = "Ecr cluster name"
    type = string
}

variable prod_env_prefix {}

variable prod_ecr_repo_name {
    description = "ECR repo name"
    type = string
}

variable prod_ecs_cluster_name {
    description = "Ecr cluster name"
    type = string
}

variable prod_avail_zone {
    type = list(string)
}



variable task_role_arn {}

variable ecr_image_link_prefix {}



# fron end variable
variable host_web_address {}
