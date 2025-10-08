module "iam" {
  source = "./module/iam"
}
module "SG"{
  source = "./module/security_groups"
  vpc_id = module.vpc.vpcid
}

module "vpc" {
  source = "./module/vpc"
}


module "ec2_1" {
  source = "./module/ec2"
  Name   = "${var.Name}-dev"
  SG     = module.SG.aws_security_group_id
  instance_profile = module.iam.instance_profile_name
  subnet_id        = module.vpc.pubsub1
}

module "ec2_2" {
  source = "./module/ec2"
  Name   = "${var.Name}-stage"
  SG     = module.SG.aws_security_group_id
  instance_profile = module.iam.instance_profile_name
  subnet_id        = module.vpc.pubsub2
}

module "ec2_3" {
  source = "./module/ec2"
  Name   = "${var.Name}-prod"
  SG     = module.SG.aws_security_group_id
  instance_profile = module.iam.instance_profile_name
  subnet_id        = module.vpc.pubsub1
}




module "alb" {
  source  = "./module/load_balancer"

  vpc_id  = module.vpc.vpcid

  subnets = [
    module.vpc.pubsub1,
    module.vpc.pubsub2
  ]

  SG       = module.SG.aws_security_group_id
  ec2_1_id = module.ec2_1.ec2_id
  ec2_2_id = module.ec2_2.ec2_id
  ec2_3_id = module.ec2_3.ec2_id
}