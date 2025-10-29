{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EnvSpecificS3Access",
      "Effect": "Allow",
      "Action": ${jsonencode(s3_actions)},
      "Resource": [
        "arn:aws:s3:::myproject-${env}-bucket-2025",
        "arn:aws:s3:::myproject-${env}-bucket-2025/*"
      ]
    }
  ]
}
