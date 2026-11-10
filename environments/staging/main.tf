
module "vpc" {
  source = "../../modules/vpc"

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs

  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "../../modules/security-groups"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

module "s3" {
  source = "../../modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
}


module "iam" {
  source = "../../modules/iam"

  environment   = var.environment
  s3_bucket_arn = module.s3.bucket_arn
}


module "ec2" {
  source = "../../modules/ec2"

  environment = var.environment

  instance_type = var.instance_type

  subnet_id = module.vpc.public_subnet_ids[0]

  security_group_id = module.security_groups.ec2_security_group_id

  instance_profile_name = module.iam.instance_profile_name
}

