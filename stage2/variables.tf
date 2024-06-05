// Basic variables 
variable aws_region {
    description = "aws region"
    type = string
}

variable aws_iam_user_id {
    description = "aws region"
    type = string

    validation {
    condition = can(regex("^[0-9]+$", var.aws_iam_user_id))
    error_message = "The aws_iam_user_id must contain only numeric characters."
    }
}


# fron end variable
variable host_web_address {
    description = "web domain"
    type = string
}


// Uat variables

variable uat_vpc_cidr_block {
    type = string
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

variable uat_env_prefix {
    description = "uat env prefix for name"
    type = string
}

variable uat_ecr_repo_name {
    description = "ECR repo name"
    type = string
}

variable uat_ecs_cluster_name {
    description = "Ecr cluster name"
    type = string
}


// Prod Variables
variable prod_env_prefix {
    description = "prod env prefix for name"
    type = string
}

variable prod_ecr_repo_name {
    description = "ECR repo name"
    type = string
}

variable prod_ecs_cluster_name {
    description = "Ecr cluster name"
    type = string
}

variable prod_avail_zone {
    description = "Prod available zones"
    type = list(string)
}

variable prod_vpc_cidr_block {
    type = string
}

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


// aws executor role arn
variable task_role_arn {
    description = "task role arn"
    type = string
}


// aws ecr image link prefix
variable ecr_image_link_prefix {
    description = "ecr image prefix for downland link"
    type = string
}