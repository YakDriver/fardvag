#!/bin/bash

# private envs
source envs.sh

# shuffle the configs around
echo "Renaming import.tf to temp_import.nottf"
mv import.tf temp_import.nottf

# go forth
terraform init -input=false
terraform plan -input=false -out=theplan
terraform apply -input=false theplan
export TF_VAR_rt_id="$(terraform output rt_id)"
export TF_VAR_another_ni_id="$(terraform output another_ni_id)"
export TF_VAR_r_id="$(terraform output r_id)"

# clean up
mv terraform.tfstate terraform.create.tfstate

# shuffle the configs around
echo "Renaming create.tf to temp_create.nottf"
mv temp_import.nottf import.tf
mv create.tf temp_create.nottf

terraform init -input=false
terraform import -input=false aws_route.internal-default-route "r-${TF_VAR_rt_id}_124.0.0.0/16"
terraform plan -input=false -out=newplan
mv terraform.tfstate terraform.import.tfstate
terraform apply -input=false newplan

mv temp_create.nottf create.tf
echo "Renaming terraform config files back to original"
