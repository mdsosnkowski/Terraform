# Project 2 – CICD Build using GitHub Actions

## Overview
This project automates the **build and deployment** of **Project 1** infrastructure using **GitHub Actions**.  
The workflow provisions AWS resources defined in Project 1 whenever changes are pushed to the repository.  

---

## Purpose
- Automate Terraform workflows to **reduce manual steps**.  
- Ensure **consistent infrastructure deployment**.  
- Enable **continuous integration and deployment** of AWS resources.  

---

## Components
- **GitHub Actions Workflow**:  
  - Runs `terraform init`, `terraform validate`, `terraform plan`, and `terraform apply`.  
  - Triggered on push to specific branches (e.g., `main` or `dev`).  
- **Project 1 Terraform Configuration**:  
  - Uses the Terraform configuration from Project 1 as the source.  
- **Environment Management**:  
  - Can manage multiple environments (dev, staging, prod) via workflow variables or separate workspaces.  

---

## Files
- `.github/workflows/terraform.yml` → CI/CD workflow definition for GitHub Actions  
- `.gitignore` → Excludes Terraform state, logs, and temporary files  
- Optional: environment variable files or secrets for AWS credentials  

---

## Prerequisites
- GitHub repository containing both Project 1 and Project 2 (or Project 1 as a submo
