
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security group will be created"
  type        = string
}

variable "allowed_http_cidr" {
  description = "Allowed HTTP source CIDR"
  type        = string
  default     = "0.0.0.0/0"
}
