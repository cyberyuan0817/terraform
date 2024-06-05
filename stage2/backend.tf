

terraform {
  backend "s3" {
    bucket         = "be-terraform-state-bucket"
    key            = "global/S3/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "be-terraform-lock-table"
    encrypt        = true
  }
}
