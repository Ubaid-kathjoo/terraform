{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowEnvSpecificS3Access",
      "Effect": "Allow",
      "Action": ${jsonencode(s3_actions)},
      "Resource": [
        "arn:aws:s3:::${env}-bucket-*",
        "arn:aws:s3:::${env}-bucket-*/*"
      ]
    }
  ]
}
