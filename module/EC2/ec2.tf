resource "aws_instance" "this" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type

  tags = {
    Name = "${var.env}-instance"
  }
}


data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}