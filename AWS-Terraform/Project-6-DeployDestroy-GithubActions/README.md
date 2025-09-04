# Project 6 – CICD Terraform for All-in-One Build and Destroy using GitHub Actions.

## Overview
This project automates the **Production of the build, deployment, and destroy** of **Project 5 ** infrastructure using **GitHub Actions Artifacts**.  
  
1. Create the main infrastructure and use GitHub Artifacts to store the statefile.
2. On GitHub go to actions and run the "terraform-destroy" workflow file.

## Purpose
Right now, your workflow only builds (applies) infrastructure. Terraform doesn’t destroy unless you explicitly run `terraform destroy`. You don’t need a completely new workflow, but it’s often cleaner to keep **two separate workflows**:

- **Deploy (Apply)** → runs on push to `main`  
- **Destroy** → runs manually (so you don’t accidentally wipe infra)

---

### Example: `destroy.yml` workflow

…the destroy workflow only runs when you manually trigger it. Here’s how to do that in GitHub:

Go to your GitHub repo.

Click the Actions tab.

On the left-hand side, you’ll see a list of workflows (your “Terraform CI Pipeline” and the new “Terraform Destroy Pipeline”).

Select Terraform Destroy Pipeline.

On the right, you’ll see a “Run workflow” button (green).

Click it → GitHub spins up the job and runs terraform destroy -auto-approve with your AWS credentials.

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


