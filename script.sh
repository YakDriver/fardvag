#!/bin/bash

# clean up
rm -r .terraform
rm terraform.tfstate

# private envs
source envs.sh

# go forth
terraform init -input=false ./create
terraform plan -input=false -out=.tfplan ./create
terraform apply -input=false .tfplan
NEW_RT_ID="$(terraform output rt_id)"

# clean up
rm -r .terraform
rm terraform.tfstate

terraform init -input=false ./import
terraform import -config=import aws_route_table.yak_rt $NEW_RT_ID
