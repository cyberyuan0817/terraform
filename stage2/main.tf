# # Uat IaC 
# module "Uat_vpc1" {
#     source = "./modules/vpc"
#     vpc_cidr_block = var.vpc_cidr_block
#     env_prefix = var.env_prefix

# }


# module "Uat_subnets" {
#     source = "./modules/subnet"
#     vpc_id = module.Uat_vpc1.vpc.id
#     subnet_cidr_block = var.subnet_cidr_block
#     env_prefix = var.env_prefix
#     avail_zone = var.avail_zone
#     subnet_names = var.subnet_names

# }


# module "Uat_igw" {
#     source = "./modules/InternetGateway"
#     vpc_id = module.Uat_vpc1.vpc.id
#     env_prefix = var.env_prefix
# }

# module "Uat_rtb" {
#     source = "./modules/RouteTable"
#     vpc_id = module.Uat_vpc1.vpc.id
#     gateway_id = module.Uat_igw.igw.id
#     env_prefix = var.env_prefix
# }


# module "Uat_rtb_association" {
#     source = "./modules/RouteTBAssociation"
#     subnet_ids_list = module.Uat_subnets.subnet_ids_list
#     route_table_id = module.Uat_rtb.rtb.id
# }

# module "Uat_security_group" {
#     source = "./modules/UatSecurityGroup"
#     vpc_id = module.Uat_vpc1.vpc.id
#     env_prefix = var.env_prefix
# }

# module "Uat_ecr_repo" {
#     source = "./modules/ECR"
#     ecr_repo_name = var.ecr_repo_name

# }



module "Uat_VPC_whole" {
    source = "./modules/2_UatVPC"
    vpc_cidr_block = var.uat_vpc_cidr_block
    env_prefix = var.uat_env_prefix
    ecr_repo_name = var.uat_ecr_repo_name
    ecs_cluster_name = var.uat_ecs_cluster_name
    avail_zone = var.uat_avail_zone
    subnet_names = var.uat_subnet_names
    subnet_cidr_block = var.uat_subnet_cidr_block
    uat_lb_tg = module.Prod_VPC_whole.lb_tg
    peering_vpc_cidr = var.prod_vpc_cidr_block
    vpc_peering_id = module.Prod_VPC_whole.vpc_peering_id
    task_role_arn = var.task_role_arn
    ecr_image_link_prefix = var.ecr_image_link_prefix
    aws_iam_user_id = var.aws_iam_user_id
    aws_region = var.aws_region


}

# # Prod IaC

module "Prod_VPC_whole" {
    source = "./modules/1_ProdVPC"
    vpc_cidr_block = var.prod_vpc_cidr_block
    prod_env_prefix = var.prod_env_prefix
    prod_ecr_repo_name = var.prod_ecr_repo_name
    prod_ecs_cluster_name = var.prod_ecs_cluster_name
    avail_zone = var.prod_avail_zone
    prod_public_subnet_names = var.prod_public_subnet_names
    prod_public_subnet_cidr_block = var.prod_public_subnet_cidr_block
    prod_private_subnet_names = var.prod_private_subnet_names
    prod_private_subnet_cidr_block = var.prod_private_subnet_cidr_block

    vpc_uat_id_for_peering = module.Uat_VPC_whole.uat_vpc.id
    vpc_uat_cidr_for_peering = module.Uat_VPC_whole.uat_vpc.cidr_block
    vpc_uat_rtb_id = module.Uat_VPC_whole.uat_rtb.id

    uat_ecs_service_info = module.Uat_VPC_whole.uat_ecs_info
    uat_subnet_ids_list = module.Uat_VPC_whole.uat_subnet_ids_list
    nat_load_balancer_security_group_id = module.Uat_VPC_whole.nat_load_balancer_security_group_id
    uat_ecs_taskdefinition = module.Uat_VPC_whole.uat_ecs_taskdefinition

    vpc_peering_id = module.Prod_VPC_whole.vpc_peering_id
    peering_vpc_cidr = var.uat_vpc_cidr_block

    task_role_arn = var.task_role_arn
    ecr_image_link_prefix = var.ecr_image_link_prefix


    // Front end route
    host_web_address = var.host_web_address
    aws_iam_user_id = var.aws_iam_user_id
    aws_region = var.aws_region


    
}




