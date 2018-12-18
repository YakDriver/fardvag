package main

import (
	"fmt"
	"os"

	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

func main() {

	sess, _ := session.NewSession()

	// Create S3 service client
	svc := s3.New(sess)

	result, err := svc.ListBuckets(nil)
	if err != nil {
		exitErrorf("Unable to list buckets, %v", err)
	}

	fmt.Printf("Buckets: %v\n", len(result.Buckets))

	/*
		for _, b := range result.Buckets {
			fmt.Printf("* %s created on %s\n",
				aws.StringValue(b.Name), aws.TimeValue(b.CreationDate))
			break
		}
	*/
}

func exitErrorf(msg string, args ...interface{}) {
	fmt.Fprintf(os.Stderr, msg+"\n", args...)
	os.Exit(1)
}
