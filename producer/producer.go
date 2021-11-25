package main

import (
	"fmt"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/credentials"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
)

func main() {
	queueUrl 	   := "https://sqs.us-east-1.amazonaws.com/576308049910/tcc-esvm-ufpe.fifo"
	accessKeyId    := "AKIAYMLVC673FOALQBUM"
	accessSecret   := "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"
	region 		   := "us-east-1"
	messageGroupId := "test"

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

	_, err = svc.SendMessage(&sqs.SendMessageInput{
		MessageGroupId: &messageGroupId,
		MessageBody: aws.String("Sending a new message at: "+time.Now().String()),
		QueueUrl:    &queueUrl,
	})
	if err != nil {
		fmt.Println("failed to send message", err)
		return
	}

	fmt.Println("message sent successfully")
}
