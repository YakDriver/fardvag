#!/bin/bash

echo Clean-up AWS
echo WARNING: This will revert local files back to last
echo commit. If you are working on *services*, specifically
echo elasticache, iam, rds, or s3, make sure this does not
echo revert your work!

read -n 1 -s -r -p "Press any key to continue"

cd $GOPATH/src/github.com/aws/aws-sdk-go
git checkout -- service/elasticache/examples_test.go
git checkout -- service/iam/examples_test.go
git checkout -- service/rds/examples_test.go
git checkout -- service/s3/bucket_location_test.go
git checkout -- service/s3/s3crypto/decryption_client.go
git checkout -- service/s3/sse_test.go
