package main

import (
	"fmt"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials/processcreds"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

func main() {
	// Create credentials using the ProcessProvider.
	/*
		creds := credentials.NewCredentials(&processcreds.ProcessProvider{
			Process:    "./stdin.sh",
			Timeout:    60000,
			MaxBufSize: 500,
		})
	*/

	creds := processcreds.NewCredentials("./stdin.sh")

	sess, _ := session.NewSession(&aws.Config{
		Region:      aws.String("us-east-1"),
		Credentials: creds,
	})

	// Create service client value configured for credentials.
	svc := s3.New(sess, &aws.Config{Credentials: creds})

	result, err := svc.ListBuckets(nil)
	if err != nil {
		exitErrorf("Unable to list buckets, %v", err)
	}

	fmt.Println("Buckets:")

	for _, b := range result.Buckets {
		fmt.Printf("* %s created on %s\n",
			aws.StringValue(b.Name), aws.TimeValue(b.CreationDate))
	}
}

func exitErrorf(msg string, args ...interface{}) {
	fmt.Fprintf(os.Stderr, msg+"\n", args...)
	os.Exit(1)
}
