resource "aws_s3_bucket" "env_bucket" {
  bucket = var.bucket_name
}




resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.env_bucket.id

policy = templatefile("${path.module}/policies/s3_bucket_policy.json.tpl")
}
