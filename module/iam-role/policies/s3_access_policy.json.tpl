policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Effect   = "Allow"
      Action   = var.s3_actions
      Resource = "*"
    }
  ]
})
    