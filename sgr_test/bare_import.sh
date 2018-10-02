#!/bin/bash

source envs.sh

terraform init -input=false
terraform import -input=false aws_security_group_rule.sgr sg-0a2f2e03512aea34b_in_tcp_1521_sg-0a2f2e03512aea34b
