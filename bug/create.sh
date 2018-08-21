#!/bin/bash

# private envs
source envs.sh

# go forth
terraform init -input=false
terraform plan -input=false -out=theplan
terraform apply -input=false theplan
rt_id="$(terraform output rt_id)"

# clean up
rm terraform.tfstate

terraform init -input=false
terraform import -input=false aws_route_table.rt "${rt_id}"
terraform plan -input=false -out=newplan
terraform apply -input=false newplan
