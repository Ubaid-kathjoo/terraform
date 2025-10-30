resource "aws_iam_role" "ec2_role" {
  name = "my-ec2-s3-role-${var.env}"
    assume_role_policy = file("${path.module}/policies/ec2_trust_policy.json.tpl")


}
resource "aws_iam_policy" "s3_access_policy" {
  name   = "${var.role_name}-policy-${var.env}"

  policy = templatefile("${path.module}/policies/s3_access_policy.json.tpl", {
    env        = var.env
    s3_actions = var.s3_actions
  })
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "instance-ec2-profile-${var.env}"
  role = aws_iam_role.ec2_role.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}