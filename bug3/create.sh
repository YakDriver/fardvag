#!/bin/bash

# private envs
source envs.sh

# go forth
terraform init -input=false
terraform plan -input=false -out=theplan
terraform apply -input=false theplan
rt_id="$(terraform output rt_id)"

# clean up
mv terraform.tfstate terraform.create.tfstate

terraform init -input=false
terraform import -input=false aws_route_table.rt "${rt_id}"
terraform plan -input=false -out=newplan
mv terraform.tfstate terraform.import.tfstate
#terraform apply -input=false newplan
