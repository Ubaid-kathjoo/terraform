resource "aws_s3_bucket" "env_bucket" {
  count = var.env == "dev" || var.env == "stage" || var.env == "prod" ? 1 : 0

  bucket = "${var.my_project}-${var.env}-bucket"

  tags = {
    Name        = "${var.my_project}-${var.env}-bucket"
    Environment = var.env
  }
}
