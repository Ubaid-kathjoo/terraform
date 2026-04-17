resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.env_bucket.id

  policy = jsonencode(
    jsondecode(
      templatefile("${path.module}/policies/s3_bucket_policy.json.tpl", {
        account_id  = var.account_id
        env         = var.env
        bucket_name = var.bucket_name
      })
    )
  )
}