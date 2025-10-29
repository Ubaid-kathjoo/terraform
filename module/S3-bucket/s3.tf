data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "env_bucket" {
  bucket = "${var.my_project}-${var.env}-bucket-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 2
}


resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.env_bucket.id

  policy = templatefile("${path.module}/policies/s3_bucket_policy.json.tpl", {
  bucket_name = aws_s3_bucket.env_bucket.id
  env         = var.env
  account_id  = data.aws_caller_identity.current.account_id
  })
}
