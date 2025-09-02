# Project 4 – CICD Terraform "Destroy" the build using GitHub Actions.

## Overview
This project automates the **destroy of the build and deployment** of **Project 3 ** infrastructure using **GitHub Actions**.  
The workflow provisions AWS resources defined in Project 1 whenever changes are pushed to the repository.  

---

## Purpose
Right now, your workflow only builds (applies) infrastructure. Terraform doesn’t destroy unless you explicitly run `terraform destroy`. You don’t need a completely new workflow, but it’s often cleaner to keep **two separate workflows**:

- **Deploy (Apply)** → runs on push to `main`  
- **Destroy** → runs manually (so you don’t accidentally wipe infra)

---

### Example: `destroy.yml` workflow

You can add a `destroy.yml` workflow that you trigger from the GitHub Actions UI (`workflow_dispatch`):

```yaml
name: Terraform Destroy Pipeline

on:
  workflow_dispatch:   # allows you to trigger manually

jobs:
  terraform-destroy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v3

      # Init
      - name: Terraform Init
        run: terraform init
        working-directory: AWS-Terraform/Project-4-Destroy-GitHubAction-Build/main

      # Destroy
      - name: Terraform Destroy
        run: terraform destroy -auto-approve
        working-directory: AWS-Terraform/Project-4-Destroy-GitHubAction-Build/main
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: us-east-1


