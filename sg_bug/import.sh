#!/bin/bash

# private envs
source envs.sh

# go forth
terraform init -input=false
terraform plan -input=false -out=theplan
terraform apply -input=false theplan
sg_id="$(terraform output sg_id)"

terraform state rm aws_security_group.yak-deleterious
terraform state rm aws_security_group_rule.ingress
terraform state rm aws_security_group_rule.ingress_2
terraform state list

terraform import -input=false aws_security_group.yak-deleterious "${sg_id}"
terraform plan -input=false -out=newplan
terraform apply -input=false newplan

