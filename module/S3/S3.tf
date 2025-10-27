resource "aws_s3_bucket" "env_bucket" {
  bucket = "${var.my_project}-name" 

}