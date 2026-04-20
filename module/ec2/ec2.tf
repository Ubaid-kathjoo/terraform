resource "aws_instance" "this" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello from ${var.env} server</h1>" > /var/www/html/index.html
              EOF

  tags = {
  Name = "${var.env}-instance-new"
}


data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}