# Project 1 - Default VPC
terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}
# Provider and region of the VPC
provider "aws" {
  region = "us-east-1"
}

# Resource of the VPC
resource "aws_vpc" "main"{
    cidr_block = "10.0.0.0/16"
}