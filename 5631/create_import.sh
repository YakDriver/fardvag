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
config_dir=./create

source $config_dir/envs.sh

terraform init -input=false $config_dir
terraform import -config=$config_dir aws_route_table.import_rt "${new_rt_id}"
terraform plan -input=false -out=$config_dir/.tfplan $config_dir
#terraform apply -input=false "$config_dir/.tfplan"
