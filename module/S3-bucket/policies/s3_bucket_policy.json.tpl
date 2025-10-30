{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowRoleAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${account_id}:role/my-ec2-s3-role-${env}"
      },
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::${bucket_name}",
        "arn:aws:s3:::${bucket_name}/*"
      ]
    }
  ]
}
