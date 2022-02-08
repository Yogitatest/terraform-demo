provider "aws" {
  region = "${var.region}"
}



module "s3_bucket" {
   source = "./modules/S3"
   
   bucket = log-upload-bucket
   
   versioning = {
    enabled = true
   }
   
   tags = {
    app = "{var.app}"
	env = "${var.environment}"
   }
  
}

module "sqs_queue" {
   source = "./modules/sqs"
   
   
   sqs_name = s3-upload-queue
   
   tags = {
    app = "{var.app}"
	env = "${var.environment}"
   }
   
}


resource "aws_sqs_queue_policy" "upload_queue_policy" {
  queue_url = module.sqs_queue.sqs_queue_id

  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "1",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "sqs:SendMessage",
        "Resource": "${module.sqs_queue.sqs_queue_arn}",
		"Condition": {
        "ArnEquals": { "aws:SourceArn": "${module.s3_bucket.s3_bucket_arn}" }
        }
      }
    ]
  }
  POLICY
}


resource "aws_s3_bucket_notification" "bucket_notif" {
  bucket = "${module.s3_bucket.s3_bucket_id}"

  queue {
    queue_arn = "${module.sqs_queue.sqs_queue_arn}"
    events    = ["s3:ObjectCreated:*"]
  }
}