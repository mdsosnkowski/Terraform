# Project 1 – VPC in AWS with One Publicly Available EC2 Instance

## Overview
This project provisions a basic AWS infrastructure using **Terraform**.  
It creates a **default VPC** and launches a single **Amazon Linux EC2 instance** that can be accessed via **EC2 Instance Connect**.  

> **Fix Applied**: The initial configuration referenced the wrong security group name.  
> This has been corrected so the EC2 instance now attaches to the proper security group for Instance Connect access.  

---

## Components Created
- **Default VPC**: Ensures a VPC is available for networking resources.  
- **Security Group**: Allows inbound SSH traffic (port 22) from EC2 Instance Connect.  
- **EC2 Instance**:  
  - Amazon Linux 2023 AMI  
  - `t2.micro` instance type (free-tier eligible)  
  - Tagged as `web-server`  

---

## Files
- `main.tf` → Terraform configuration (VPC, security group, EC2)  
- `.gitignore` → Ensures state files, caches, and secrets are not committed  

---

## Usage
### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed  
- AWS credentials configured via `aws configure` or environment variables  
- An AWS account with access to `us-east-1`  

### Steps
1. Initialize the working directory:
   ```bash
   terraform init
