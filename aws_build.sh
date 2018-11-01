#!/bin/bash

success=0

cd $GOPATH/src/github.com/aws/aws-sdk-go
make generate

if [ ! $? = 0 ]; then
    success=1
fi

if [ $success = 0 ]; then
    echo "Successfully generated aws-sdk-go"
else
    echo "Failed to generate aws-sdk-go"
fi
