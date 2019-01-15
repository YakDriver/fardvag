#!/bin/bash

# go forth
terraform init -input=false
terraform plan -input=false -out=theplan
terraform apply -input=false theplan

