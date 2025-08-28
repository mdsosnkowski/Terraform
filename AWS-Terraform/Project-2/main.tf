# Terraform Example 1: Default VPC and EC2 with no SSH
# Note: the Security Group added after build did not allow for ssh from instnace connect 
# Fix: access using instance connect
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a Default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC for EC2"
  }
}
# Create Security Group for EC2 Instance Connect
resource "aws_security_group" "instance_connect" {
  name_prefix = "ec2-instance-connect-"
  vpc_id      = aws_default_vpc.default.id
  description = "Security group for EC2 Instance Connect"

  # Allow EC2 Instance Connect (SSH on port 22 from AWS service)
  # EC2 Instance Connect uses specific IP ranges for each region
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0" # EC2 Instance Connect IP range for us-east-1
    ]
    description = "EC2 Instance Connect"
  }
}
# Create a basic  EC2 instance without SSH
resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2023 AMI
  instance_type = "t2.micro"              # Free tier eligible
  # key_name              = "your-key-pair-name"     # Replace with your key pair name
  vpc_security_group_ids = [aws_security_group.instance_connect.id]
  #subnet_id             = aws_subnet.public.id

  tags = {
    Name = "web-server"
  }
}