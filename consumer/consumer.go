package main

import (
	"fmt"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
)

func main() {
	queueUrl 	   		:= "https://sqs.us-east-1.amazonaws.com/576308049910/tcc-esvm-ufpe.fifo"
	accessKeyId    		:= "AKIAYMLVC673FOALQBUM"
	accessSecret   		:= "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"
	region 		   		:= "us-east-1"
	maxNumberOfMessages := int64(1)

	sess, err := session.NewSessionWithOptions(session.Options{
		Config: aws.Config{
			Region: &region,
			Credentials: credentials.NewStaticCredentials(accessKeyId, accessSecret, ""),
		},
	})
	if err != nil {
		fmt.Println("failed to create aws session", err)
		return
	}

	svc := sqs.New(sess)

	output, err := svc.ReceiveMessage(&sqs.ReceiveMessageInput{
		QueueUrl: &queueUrl,
		MaxNumberOfMessages: &maxNumberOfMessages,
	})
	if err != nil {
		fmt.Println("failed to download messages", err)
		return
	}

	fmt.Println(output.String())
}
