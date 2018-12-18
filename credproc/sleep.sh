#!/bin/bash

>&2 echo "Please enter your AWS key id:"
read -r keyid
>&2 echo "Please enter your AWS secret key:"
read -r secret

echo "{\"Version\": 1,"
sleep 20

echo "\"AccessKeyId\": \"${keyid}\","
sleep 10

echo "\"SecretAccessKey\": \"${secret}\"}"
