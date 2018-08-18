#!/bin/bash

echo "***************************************************************"
echo Create
echo "***************************************************************"

# clean up
rm -r .terraform
rm terraform.tfstate

# private envs
source envs_create.sh

# go forth
terraform init -input=false ./create
terraform plan -input=false -out=.tfplan ./create
terraform apply -input=false .tfplan
NEW_RT_ID="$(terraform output rt_id)"

echo "***************************************************************"
echo Import
echo "***************************************************************"

# clean up
rm -r .terraform
rm terraform.tfstate

# private envs
source envs_import.sh

terraform init -input=false ./import
#terraform import -config=import aws_route_table.yak_rt $NEW_RT_ID
terraform import -config=import aws_route.yak_r "${NEW_RT_ID}"_"${TF_VAR_destination_cidr_ipv6}"
