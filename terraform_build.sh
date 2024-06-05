#!/bin/bash

# go to the stage 1 folder
cd stage1

# Run Terraform commands in the first folder
terraform init
terraform plan
terraform apply -auto-approve

# go to the stage 2 folder
cd ../stage2

# Run Terraform commands in the second folder
terraform init
terraform plan
terraform apply -auto-approve

