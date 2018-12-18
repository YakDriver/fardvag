echo Run Tests
echo CAUTION: This is about to write/delete AWS
echo config/credential files so be careful.

read -n 1 -s -r -p "Press any key to continue"

file="credproc.log"

echo ""
echo "------------------------------------------------------------------------"
echo "Test 1"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=0
export AWS_SHARED_CREDENTIALS_FILE=config_onlycp.ini
export AWS_CONFIG_FILE=

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 2"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=0
export AWS_SHARED_CREDENTIALS_FILE=config_both.ini
export AWS_CONFIG_FILE=

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 3"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_onlycp.ini
export AWS_CONFIG_FILE=config_onlycred.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 4"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_both.ini
export AWS_CONFIG_FILE=config_onlycred.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 5"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=0
export AWS_SHARED_CREDENTIALS_FILE=config_onlycp.ini
export AWS_CONFIG_FILE=

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 6"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=0
export AWS_SHARED_CREDENTIALS_FILE=config_both.ini
export AWS_CONFIG_FILE=

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 7"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_onlycp.ini
export AWS_CONFIG_FILE=config_onlycred.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 8"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_both.ini
export AWS_CONFIG_FILE=config_onlycred.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 9"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=
export AWS_CONFIG_FILE=config_onlycp.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 10"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_onlycred.ini
export AWS_CONFIG_FILE=config_onlycp.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 11"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=
export AWS_CONFIG_FILE=config_both.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 12"

unset AWS_ACCESS_KEY
unset AWS_SECRET_ACCESS_KEY
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_onlycred.ini
export AWS_CONFIG_FILE=config_both.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 13"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=
export AWS_CONFIG_FILE=config_onlycp.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 14"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_onlycred.ini
export AWS_CONFIG_FILE=config_onlycp.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 15"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=
export AWS_CONFIG_FILE=config_both.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 16"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_onlycred.ini
export AWS_CONFIG_FILE=config_both.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

echo "------------------------------------------------------------------------"
echo "Test 17"

export AWS_ACCESS_KEY=<access_key>
export AWS_SECRET_ACCESS_KEY=<secret_access_key>
unset AWS_PROFILE
export AWS_REGION=us-west-2
export AWS_SDK_LOAD_CONFIG=1
export AWS_SHARED_CREDENTIALS_FILE=config_both.ini
export AWS_CONFIG_FILE=config_both.ini

echo "Before line count:" $(cat "${file}" | wc -l)

go run giveita.go

echo "After go line count:" $(cat "${file}" | wc -l)

echo "Buckets: $(aws s3 ls | wc -l)"

echo "After CLI line count:" $(cat "${file}" | wc -l)

