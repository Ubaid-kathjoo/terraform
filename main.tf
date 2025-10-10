module "iam" {
  source = "./module/iam"
  env = var.env
}
module "SG"{
  source = "./module/security_groups"
  vpc_id = module.vpc.vpcid
  env = var.env
}

module "vpc" {
  source = "./module/vpc"
  env = var.env
}


module "ec2_1" {
  count = var.env== "dev" ? 1:0
  source = "./module/ec2"
  Name   = "${var.Name}-${var.env}"
  SG     = module.SG.aws_security_group_id
  instance_profile = module.iam.instance_profile_name
  subnet_id        = module.vpc.pubsub1
}

module "ec2_2" {
  count = var.env== "stage" ? 2:0
  source = "./module/ec2"
  Name   = "${var.Name}-${var.env}"
  SG     = module.SG.aws_security_group_id
  instance_profile = module.iam.instance_profile_name
  subnet_id        = module.vpc.pubsub2
}

module "ec2_3" {
  count = var.env== "prod" ? 3:0
  source = "./module/ec2"
  Name   = "${var.Name}-${var.env}"
  SG     = module.SG.aws_security_group_id
  instance_profile = module.iam.instance_profile_name
  subnet_id        = module.vpc.pubsub1
}




module "alb" {
  source  = "./module/load_balancer"

  vpc_id  = module.vpc.vpcid
  env     = var.env

  subnets = [
    module.vpc.pubsub1,
    module.vpc.pubsub2
  ]

  SG = module.SG.aws_security_group_id

  instance_ids = (
    var.env == "dev"   ? module.ec2_1.ec2_id :
    var.env == "stage" ? module.ec2_2.ec2_id :
    var.env == "prod"  ? module.ec2_3.ec2_id :
    []
  )
}
