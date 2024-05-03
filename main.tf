provider "aws" {
    region = "ap-southeast-2"
}





module "myvpc1" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    env_prefix = var.env_prefix

}