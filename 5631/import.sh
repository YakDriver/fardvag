#!/bin/bash

echo "***************************************************************"
echo Create
echo "***************************************************************"

config_dir=./create

# private envs
source $config_dir/envs.sh

# go forth
terraform init -input=false $config_dir
terraform plan -input=false -out=$config_dir/.tfplan $config_dir
terraform apply -input=false "$config_dir/.tfplan"
new_rt_id="$(terraform output rt_id)"

echo "***************************************************************"
echo Import
echo "***************************************************************"

# clean up
#rm -r .terraform
rm terraform.tfstate
#rm .tfplan

# private envs
config_dir=./import

source $config_dir/envs.sh

terraform init -input=false $config_dir
terraform import -config=$config_dir aws_route.imp_route_1 r-"${new_rt_id}"_"${TF_VAR_destination_cidr_ipv4}"
terraform import -config=$config_dir aws_route.imp_route_2 r-"${new_rt_id}"_"${TF_VAR_destination_cidr_ipv6}"
terraform plan -input=false -out=$config_dir/.tfplan $config_dir
#terraform apply -input=false "$config_dir/.tfplan"
