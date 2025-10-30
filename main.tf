module "s3_dev" {
  source = "./module/S3-bucket"
  my_project = "myproject"
  env = "dev"
}

module "s3_stage" {
  source       = "./module/S3-bucket"
  my_project  = "myproject"
  env          = "stage"
}

module "s3_prod" {
  source       = "./module/S3-bucket"
  my_project = "myproject"
  env          = "prod"
}

module "iam_test" {
  source     = "./module/iam-role"
  env        = "test"
  s3_actions = ["s3:*"]
  role_name   = "test-role"
}

module "iam_stage" {
  source     = "./module/iam-role"
  env        = "stage"
  s3_actions = ["s3:GetObject", "s3:PutObject"]  
  role_name   = "stage-role"
  }

module "iam_prod" {
  source     = "./module/iam-role"
  env        = "prod"
  s3_actions = ["s3:GetObject", "s3:ListBucket"]
  role_name   = "prod-role"
}









