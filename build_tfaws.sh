#!/bin/bash

current_pwd=$PWD
success=0

cd $GOPATH/src/github.com/terraform-providers/terraform-provider-aws
make fmt
make build

if [ $? = 0 ]; then
    if [ ! -d "$DIRECTORY" ]; then
        mkdir -p ~/.terraform.d/plugins
    fi
    cp $GOPATH/bin/terraform-provider-aws ~/.terraform.d/plugins
    if [ ! $? = 0 ]; then
        success=1
    fi
else
    success=1
fi

cd $current_pwd

if [ $success = 0 ]; then
    echo "Successfully built and installed terraform-provider-aws"
else
    echo "Failed to build and install terraform-provider-aws"
fi
