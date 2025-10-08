resource "aws_instance" "MyWebinstancenew" {
  ami           = "ami-01b6d88af12965bb6"  # Amazon Linux 2023
  instance_type = "t2.micro"
  

  iam_instance_profile   = var.instance_profile
  vpc_security_group_ids = [var.SG]
  subnet_id = var.subnet_id

  tags = {
    Name = var.Name
  }

  user_data = file("${path.module}/user-data.sh.tpl")


  user_data_replace_on_change = true

  lifecycle {
    create_before_destroy = true
 
 
 }
}

output "ec2_id" {
  value = aws_instance.MyWebinstancenew.id
}