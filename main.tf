
# module "SG"{
#   source = "./module/security_groups"
#   vpc_id = module.vpc.vpcid
#   env = var.env
# }

# module "vpc" {
#   source = "./module/vpc"
#   env = var.env
# }


# module "ec2_1" {
#   count = var.env== "dev" ? 1:0
#   source = "./module/ec2"
#   Name   = "${var.Name}-${var.env}"
#   SG     = module.SG.aws_security_group_id
#   instance_profile = module.iam-role.instance_profile_name
#   subnet_id        = module.vpc.pubsub1
# } 

# module "ec2_2" {
#   count = var.env== "stage" ? 2:0
#   source = "./module/ec2"
#   Name   = "${var.Name}-${var.env}"
#   SG     = module.SG.aws_security_group_id
#   instance_profile = module.iam-role.instance_profile_name
#   subnet_id        = module.vpc.pubsub2
# }

# module "ec2_3" {
#   count = var.env== "prod" ? 3:0
#   source = "./module/ec2"
#   Name   = "${var.Name}-${var.env}"
#   SG     = module.SG.aws_security_group_id
#   instance_profile = module.iam-role.instance_profile_name
#   subnet_id        = module.vpc.pubsub1
# }




# module "alb" {
#   source  = "./module/load_balancer"

#   vpc_id  = module.vpc.vpcid
#   env     = var.env

#   subnets = [
#     module.vpc.pubsub1,
#     module.vpc.pubsub2
#   ]

#   SG = module.SG.aws_security_group_id

#   ec2_1_id = module.ec2_1[*].ec2_id
#   #ec2_2_id = module.ec2_2[*].ec2_id
#   #ec2_3_id = module.ec2_3[*].ec2_id
#   ec2_2_id = [for e in module.ec2_2 : e.ec2_id]
#   ec2_3_id = [for e in module.ec2_3 : e.ec2_id]
# }


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









