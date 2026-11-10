variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDR blocks"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDR blocks"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "bucket_name" {
  description = "Unique DEV S3 bucket name"
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type for DEV"
  type        = string
  default     = "t3.micro"
}