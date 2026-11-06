output "bucket_name" {
  value = aws_s3_bucket.primary.id
}

output "bucket_arn" {
  value = aws_s3_bucket.primary.arn
}

output "log_bucket_name" {
  value = aws_s3_bucket.logs.id
}
