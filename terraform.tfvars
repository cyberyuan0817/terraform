# UAT variables
uat_vpc_cidr_block = "10.0.0.0/16"
uat_subnet_cidr_block = ["10.0.10.0/24", "10.0.20.0/24"]
uat_subnet_names = ["uat_subnet1", "uat_subnet2"]
uat_env_prefix = "UAT"
uat_avail_zone = ["ap-southeast-2a", "ap-southeast-2b"]
uat_ecr_repo_name = "pawsandclaws_web"
uat_ecs_cluster_name = "uat_cluster"


# Prod Variables
prod_env_prefix = "PROD"
prod_vpc_cidr_block = "10.20.0.0/16"
prod_public_subnet_cidr_block = ["10.20.10.0/24", "10.20.20.0/24"]
prod_public_subnet_names = ["prod_public_subnet1", "prod_public_subnet2"]
prod_private_subnet_cidr_block = [ "10.20.30.0/24", "10.20.40.0/24"]
prod_private_subnet_names = ["prod_private_subnet1", "prod_private_subnet2"]
prod_avail_zone = ["ap-southeast-2a", "ap-southeast-2b"]
prod_ecr_repo_name = "pawsandclaws_web_prod"
prod_ecs_cluster_name = "prod_cluster"


# ECS task role
task_role_arn = "arn:aws:iam::211125759186:role/ExecutionRole"
ecr_image_link_prefix = "211125759186.dkr.ecr.ap-southeast-2.amazonaws.com"



# Front end part
host_web_address = "yuanpawsnclawshotel.com"
