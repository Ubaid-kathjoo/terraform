resource "aws_iam_role" "ec2_role" {
  name = "my-ec2-s3-role-${var.env}"
    assume_role_policy = file("${path.module}/policies/ec2_trust_policy.json.tpl")


}
resource "aws_iam_policy" "s3_access_policy" {
  name = "S3-access-policy-${var.env}"
  policy = file("${path.module}/policies/s3_access_policy.json.tpl")
  

}
resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "instnace-ec2-profile-role-${var.env}"
  role = aws_iam_role.ec2_role.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}