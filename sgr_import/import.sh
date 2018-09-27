#!/bin/bash

# private envs
source envs.sh

# go forth
terraform init -input=false
terraform plan -input=false -out=theplan
terraform apply -input=false theplan
sg_id="$(terraform output sg_id)"

terraform state list
terraform state rm aws_security_group_rule.orak-clay

terraform import -input=false aws_security_group_rule.orak-clay "${sg_id}_in_tcp_1521_10.1.0.0/16"
terraform plan -input=false -out=newplan
#terraform apply -input=false newplan

