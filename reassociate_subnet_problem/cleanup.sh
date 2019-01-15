#!/bin/bash

echo Clean-up Tool
echo CAUTION: This will delete files from your system.
echo It should only delete files that are not needed
echo but beware...

read -n 1 -s -r -p "Press any key to continue"

echo

rm -r .terraform
rm *tfstate*
rm terraform_create.log
rm theplan

echo
