# Retrieve the latest official Ubuntu 24.04 LTS AMI
data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}


# Create the EC2 instance
resource "aws_instance" "this" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  depends_on = [var.security_group_id] # Ensure IAM instance profile is created before the instance

  # Attach the IAM instance profile
  iam_instance_profile = var.instance_profile_name

  # Require IMDSv2 for instance metadata access
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # Encrypted 8 GiB root volume
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }


  user_data = file("${path.module}/automation.sh")


  tags = {
    Name        = "${var.environment}-ec2"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
