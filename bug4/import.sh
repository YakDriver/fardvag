#!/bin/bash

#source envs.sh

echo "***************************************************************"
echo Import
echo "***************************************************************"

test_id="$(terraform output test_id)"

#terraform state rm aws_route_table.test
terraform state rm aws_route.test
terraform state list

#terraform import -input=false aws_route_table.test "${test_id}"
terraform import -input=false aws_route.test "${test_id}_0.0.0.0/0"
terraform plan -input=false -out=newplan
terraform apply -input=false newplan
