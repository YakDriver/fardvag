#!/bin/zsh

success=0

cd $GOPATH/src/github.com/hashicorp/terraform-provider-aws
make fmt
make build

if [ $? = 0 ]; then
    directory=~/.terraform.d/plugins/yakdriver.com/hashicorp/aws/1.0.0/darwin_amd64
    if [ ! -d "${directory}" ]; then
        mkdir -p "${directory}"
    fi
    cp $GOPATH/bin/terraform-provider-aws "${directory}"
    if [ ! $? = 0 ]; then
        success=1
    fi
else
    success=1
fi

if [ $success = 0 ]; then
    echo "Successfully built and installed terraform-provider-aws"
    echo "Uses as: aws = {\n  source = \"yakdriver.com/hashicorp/aws\"\n  version = \">= 1.0\"\n}"
else
    echo "Failed to build and install terraform-provider-aws"
fi
