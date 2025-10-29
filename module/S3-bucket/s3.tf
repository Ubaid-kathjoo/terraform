data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "env_bucket" {
  bucket = "my-bucket-2025-13-28"
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.env_bucket.id
  policy = templatefile("${path.module}/policies/s3_bucket_policy.json.tpl", {
    bucket_name = aws_s3_bucket.env_bucket.id
  })
}
