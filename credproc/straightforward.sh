#!/bin/bash

file="credproc.log"
echo "$(date): another credproc run!" >> "${file}"

echo <<JSON "{
  \"Version\": 1,
  \"AccessKeyId\": \"access_key_id\",
  \"SecretAccessKey\": \"secret_access_key\"
}"
JSON
