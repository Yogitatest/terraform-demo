output "s3_bucket_id" {
    description = "The ID of the bucket."
    value = aws_s3_bucket.bucket.id
}

output "s3_bucket_arn" {
    description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
    value = aws_s3_bucket.bucket.arn
}


