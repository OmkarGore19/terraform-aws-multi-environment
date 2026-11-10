
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "EC2 public IP address"
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "EC2 private IP address"
  value       = aws_instance.this.private_ip
}

output "public_dns" {
  description = "EC2 public DNS name"
  value       = aws_instance.this.public_dns
}

output "ami_id" {
  description = "AMI ID used by the EC2 instance"
  value       = aws_instance.this.ami
}
