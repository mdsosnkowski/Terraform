# Terraforms Project 2: Git Hub Actions to launch Default VPC and EC2 with no SSH
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
# Added block to have state on AWS as remote location.
# Replace code-bucket-<your-random-suffix> 
# with the actual bucket name that Terraform created
# Find bucket name on console use: "aws s3 ls"
# Initialize backend migration
# terraform init -migrate-state
# It should now pull state from the S3 bucket
# not your local terraform.tfstate.
# Check: terraform state list
# for the bucket, copy the backend bucket suffix: 
# code-bucket-<suffix> Test
terraform {
  backend "s3" {
    bucket         = "code-bucket-9e8fae93" # Backend S3 bucket
    key            = "terraform.tfstate"
    region         = "us-east-1" # change if needed
    #dynamodb_table = "Hcl-lock-table"
    use_lockfile = "Hcl-lock-table"
    encrypt        = true
  }
}