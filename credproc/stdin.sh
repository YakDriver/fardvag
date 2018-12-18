#!/bin/bash

>&2 echo "Please enter your AWS key id:"
read -r keyid
>&2 echo "Please enter your AWS secret key:"
read -r secret
echo <<JSON "{
  \"Version\": 1,
  \"AccessKeyId\": \"${keyid}\",
  \"SecretAccessKey\": \"${secret}\"
}"
JSON
