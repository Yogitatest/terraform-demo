output "sqs_queue_sqs_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = module.sqs_queue.sqs_queue_id
}

output "sqs_queue_sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.sqs_queue.sqs_queue_arn
}

output "s3_bucket_s3_bucket_id" {
  description = "The URL for the created Amazon S3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}

output "s3_bucket_s3_bucket_arn" {
  description = "The ARN of the S3 Bucket"
  value       = module.s3_bucket.s3_bucket_arn
}
