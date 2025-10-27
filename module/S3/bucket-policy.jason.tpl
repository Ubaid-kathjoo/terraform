resource "aws_s3_bucket_policy" "env_bucket_policy" {
  count = var.env == "dev" || var.env == "stage" || var.env == "prod" ? 1 : 0

  bucket = aws_s3_bucket.env_bucket[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAccountAccess"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "s3:*"
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.env_bucket[0].id}",
          "arn:aws:s3:::${aws_s3_bucket.env_bucket[0].id}/*"
        ]
      }
    ]
  })
}

data "aws_caller_identity" "current" {}
