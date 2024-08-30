output "bucket_name" {
  value = aws_s3_bucket.devbucket.bucket
}
output "bucket_arn" {
    value = aws_s3_bucket.devbucket.arn
  
}