#!/bin/bash

source envs.sh

echo "***************************************************************"
echo Import
echo "***************************************************************"

# clean up
rm terraform.tfstate

terraform init -input=false
terraform import aws_route_table.rt "${new_rt_id}"
terraform apply -input=false "$config_dir/.tfplan"
