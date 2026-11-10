output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ec2_security_group_id" {
  value = module.security_groups.ec2_security_group_id
}

output "s3_bucket_name" {
  value = module.s3.bucket_id
}

output "s3_bucket_arn" {
  value = module.s3.bucket_arn
}


output "iam_role_name" {
  description = "DEV EC2 IAM role name"
  value       = module.iam.iam_role_name
}

output "iam_role_arn" {
  description = "DEV EC2 IAM role ARN"
  value       = module.iam.iam_role_arn
}

output "instance_profile_name" {
  description = "DEV EC2 instance profile name"
  value       = module.iam.instance_profile_name
}

output "instance_profile_arn" {
  description = "DEV EC2 instance profile ARN"
  value       = module.iam.instance_profile_arn
}


output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "ec2_private_ip" {
  value = module.ec2.private_ip
}

output "ec2_public_dns" {
  value = module.ec2.public_dns
}

output "ec2_ami_id" {
  value = nonsensitive(module.ec2.ami_id)
}
