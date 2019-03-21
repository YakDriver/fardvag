#!/bin/bash

success=0

cd $GOPATH/src/github.com/terraform-providers/terraform-provider-aws
make fmt
make build

if [ $? = 0 ]; then
    directory=~/.terraform.d/plugins
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
else
    echo "Failed to build and install terraform-provider-aws"
fi
