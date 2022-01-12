terraform {
  required_version = ">= 0.14.7"
  required_providers {
      aws = { 
        source = "hashicorp/aws" 
        version = "3.30.0"
      }
  }
  
  backend "remote" {}
}

# ---------------------------------------------------------------------------------------

provider "aws" {
  region  = "eu-west-2"
}
	
# ----------------------------------------------------------------------------------------
# creating s3 bucket queue
# ----------------------------------------------------------------------------------------

resource "aws_s3_bucket" "bucket" {	
	bucket = "upload-bucket"
	acl = "private"
}
	
# ----------------------------------------------------------------------------------------
# creating SQS queue
# ----------------------------------------------------------------------------------------


resource "aws_sqs_queue" "queue" {
  name = "upload-queue"
  delay_seconds             = 60
  max_message_size          = 200
  message_retention_seconds = 172800
  receive_wait_time_seconds = 30
  
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "1",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:*:*:upload-queue",
      "Condition": {
        "ArnEquals": { "aws:SourceArn": "${aws_s3_bucket.bucket.arn}" }
      }
    }
  ]
}
POLICY
}

# -----------------------------------------------------------------------------------------

resource "aws_s3_bucket_notification" "bucket_notif" {
  bucket = "${aws_s3_bucket.bucket.id}"

  queue {
    queue_arn = "${aws_sqs_queue.queue.arn}"
    events    = ["s3:ObjectCreated:*"]
  }
}