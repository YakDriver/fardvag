package main

import (
	"fmt"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ec2"
)

func main() {

	sess, _ := session.NewSession()

	// Create S3 service client
	svc := ec2.New(sess)

	resourceID := "vpc-7d3b2718"
	logsARN := "arn:aws-us-gov:iam::039368651566:role/yak-test-role"
	logGroupName := "yak"

	opts := &ec2.CreateFlowLogsInput{
		LogDestinationType:       aws.String(ec2.LogDestinationTypeCloudWatchLogs),
		ResourceIds:              []*string{aws.String(resourceID)},
		ResourceType:             aws.String("VPC"),
		TrafficType:              aws.String(ec2.TrafficTypeAll),
		DeliverLogsPermissionArn: aws.String(logsARN),
		LogGroupName:             aws.String(logGroupName),
	}

	resp, err := svc.CreateFlowLogs(opts)
	if err != nil {
		exitErrorf("Error creating Flow Log for (%s), error: %s", resourceID, err)
	}

	flowLogID := *resp.FlowLogIds[0]

	fmt.Fprintf(os.Stderr, "New flow log created! %v\n", flowLogID)

	descOpts := &ec2.DescribeFlowLogsInput{
		FlowLogIds: []*string{aws.String(flowLogID)},
	}

	descResp, err := svc.DescribeFlowLogs(descOpts)
	if err != nil {
		exitErrorf("Error describing Flow Logs for id (%s): %v", resourceID, err)
	}

	fl := descResp.FlowLogs[0]
	if fl.LogDestinationType == nil {
		fmt.Fprint(os.Stderr, "LogDestinationType is nil!\n")
	} else {
		fmt.Fprintf(os.Stderr, "LogDestinationType is (%s)\n", *fl.LogDestinationType)
	}
}

func exitErrorf(msg string, args ...interface{}) {
	fmt.Fprintf(os.Stderr, msg+"\n", args...)
	os.Exit(1)
}
