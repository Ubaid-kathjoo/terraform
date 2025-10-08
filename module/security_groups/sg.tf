resource "aws_security_group" "httpd" {
  name        = "my_SG_for_ec2"
  description = "Allow HTTP and SSH inbound, all outbound traffic"
  vpc_id      = var.vpc_id

  # HTTP
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "aws_security_group_id" {
    value = aws_security_group.httpd.id
  
}