resource "aws_s3_bucket" "env_bucket" {
  bucket = "${var.my_project}-" 

  tags = {
    Name        = "${var.my_project}"
    Environment = var.env
  }
}
resource "aws_s3_bucket" "this" {
  bucket = "${var.my_project}-${var.env}"

  tags = {
    Name        = "${var.my_project}-${var.env}-bucket"
    Environment = var.env
  }
}