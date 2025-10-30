module "s3_dev" {
  count = var.env == "dev" ? 1 : 0
  source = "./module/S3-bucket"
  my_project = "myproject"
  env = var.env
}

module "s3_stage" {
  count = var.env == "stage" ? 1 : 0
  source       = "./module/S3-bucket"
  my_project  = "myproject"
  env          = var.env
}

module "s3_prod" {
  count = var.env == "prod" ? 1 : 0
  source       = "./module/S3-bucket"
  my_project = "myproject"
  env          = var.env
}

module "iam_test" {
  count = var.env == "dev" ? 1 : 0
  source     = "./module/iam-role"
  env        = "test"
  s3_actions = ["s3:*"]
  role_name   = "test-role"
}

module "iam_stage" {
  count = var.env == "stage" ? 1 : 0
  source     = "./module/iam-role"
  env        = "stage"
  s3_actions = ["s3:GetObject", "s3:PutObject"]  
  role_name   = "stage-role"
  }

module "iam_prod" {
  count = var.env == "prod" ? 1 : 0
  source     = "./module/iam-role"
  env        = "prod"
  s3_actions = ["s3:GetObject", "s3:ListBucket"]
  role_name   = "prod-role"
}