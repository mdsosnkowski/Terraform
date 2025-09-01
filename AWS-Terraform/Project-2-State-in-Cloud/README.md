# Project 2 – Migrate Local Terraform State to Remote Cloud Backend

## Overview
This project provisions an **S3 bucket** and a **DynamoDB table** to hold Terraform state files in the cloud instead of on the local machine.  
In a production environment, these resources typically already exist and are shared across teams.  

The goal is to migrate the existing **local Terraform statefile** to a secure and shared **remote backend** in AWS.

---

## Purpose
- Prepare for Terraform workflows by centralizing and securing state management.  
- Enable **team collaboration** by allowing multiple engineers to safely share infrastructure state.  
- Prevent **state corruption** and **race conditions** with DynamoDB state locking.  
- Lay the foundation for **automated CI/CD pipelines** using GitHub Actions.  

---

## Components
### Backend Infrastructure (this project)
- Creates an **S3 bucket** for storing remote state.  
- Creates a **DynamoDB table** for state locking and consistency.  

### GitHub Actions Workflow
- Runs `terraform init`, `terraform validate`, `terraform plan`, and `terraform apply`.  
- Triggered on push to specific branches (e.g., `main` or `dev`).  

### Integration with Project 1
- Uses the Terraform configuration from **Project 1 (VPC + EC2)** as the workload being managed.  

### Environment Management
- Supports multiple environments (`dev`, `staging`, `prod`) via:  
  - Terraform workspaces  
  - Separate backend state files  

---

## Files
- `.github/workflows/terraform.yml` → GitHub Actions workflow definition  
- `.gitignore` → Excludes Terraform state, logs, and temporary files  
- `main.tf` → Backend infrastructure definition (S3 + DynamoDB)  
- `backend.tf` → Backend configuration for Terraform state migration  
- *(Optional)* Environment variable files or GitHub Secrets for AWS credentials  

---

## Prerequisites
- GitHub repository containing both **Project 1** and **Project 2** (or Project 1 imported as a submodule).  
- AWS account with sufficient permissions to create:  
  - **S3 bucket**  
  - **DynamoDB table**  
- Configured **AWS CLI** or GitHub Secrets for authentication.  

---

## Step-by-Step Migration Guide

Follow these steps to migrate your local Terraform statefile to the new remote backend.

### 1. Deploy the Backend Infrastructure
First, deploy the resources needed for the backend (S3 + DynamoDB).

```bash
# Navigate to the backend project folder
cd project-2-backend

# Initialize Terraform
terraform init

# Validate the configuration
terraform validate

# Apply the backend infrastructure (creates S3 + DynamoDB)
terraform apply -auto-approve
