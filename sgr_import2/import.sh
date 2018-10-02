#!/bin/bash

# private envs
source envs.sh

# go forth
terraform init -input=false
terraform plan -input=false -out=theplan
terraform apply -input=false theplan
sg_id="$(terraform output sg_id)"

terraform state list
terraform state rm aws_security_group_rule.ingress

terraform import -input=false aws_security_group_rule.ingress "${sg_id}_in_tcp_8000_10.0.3.0/24_10.0.4.0/24"
terraform plan -input=false -out=newplan
#terraform apply -input=false newplan

