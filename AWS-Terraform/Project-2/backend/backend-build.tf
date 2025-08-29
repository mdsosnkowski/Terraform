
# Backend setup for the Bucket and Database
# to support the GitHub Actions CICD code

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

# Create rundom suffix for use with bucket id
resource "random_id" "suffix" {
  byte_length = 4
}

# S3 bucket with random suffix for code storage
resource "aws_s3_bucket" "tf_state" {
  bucket = "code-bucket-${random_id.suffix.hex}"
}

# DynamoDB for HCL-lock
resource "aws_dynamodb_table" "hcl-lock-table" {
  name           = "Hcl-lock-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S" # string
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
# 
}
terraform {
  backend "s3" {
    bucket         = "code-bucket-8bf93622" # from statefile
    key            = "terraform.tfstate"
    region         = "us-east-1" # change if needed
    dynamodb_table = "Hcl-locktable"
    encrypt        = true
  }
}
