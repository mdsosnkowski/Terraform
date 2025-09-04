# Project 6 – CICD Terraform for All-in-One Build and Destroy using GitHub Actions.

## Overview
This project automates the **Production of the build, deployment, and destroy** of **Project 5 ** infrastructure using **GitHub Actions Artifacts**.  
  
1. Create the main infrastructure and use GitHub Artifacts to store the statefile.
2. On GitHub go to actions and run the "terraform-destroy" workflow file.

## ISSUE!!
A destroy terraform actions script will  not be able to look at the Github archive and find the artifact terraform-state.
Therefore, either download the artifact locally and put it into the repo for the destruction or...  
Use a two build method: 1st create a backend as in Project 4 which holds an S3 and DDB for the terraform-state file.
Then, build the production file and migrated the backend to the S3/DDB locations.

## Purpose
What are GitHub Artifacts

Artifacts are files or directories produced by a workflow run (logs, build outputs, compiled binaries, Terraform state, etc.).
They are stored outside the repository in GitHub’s cloud storage.
They are meant to share data between workflow jobs or preserve it after a run finishes.

## Key Points

Artifacts are tied to a workflow run. They are not permanent unless you download and save them elsewhere.  

Storage costs:
Free accounts: 2 GB included for Actions storage.  
Paid storage beyond quota is billed (~$0.25 per GB/month).  
Most artifacts (like Terraform state) are tiny, so cost is negligible.  

Use cases:
Passing build outputs to subsequent jobs.  
Sharing files between different workflow runs.  
Preserving state (like your bootstrap Terraform state).  

## How it works

Create/Upload Artifact

Use the actions/upload-artifact action in your workflow.

Example:

- name: Upload artifact  
  uses: actions/upload-artifact@v3  
  with:  
    name: terraform-state  
    path: AWS-Terraform/bootstrap/terraform.tfstate  


name → identifier for the artifact.  
path → file or directory you want to upload.  

Storage

Artifacts are stored in GitHub’s cloud, not in your git repo.
Each workflow run keeps its own copy.
Download/Consume Artifact
Use actions/download-artifact to pull the files into another job or workflow.

- name: Download artifact  
  uses: actions/download-artifact@v3  
  with:  
    name: terraform-state  
    path: AWS-Terraform/bootstrap/  


The files appear in the runner at the path you specify.  
Terraform, scripts, or tests can then use them as if they were local.  

Retention  
By default, artifacts expire after 90 days.  
You can set a shorter retention with retention-days.  
After expiration, GitHub automatically deletes the artifact.  

** Visual Flow
Workflow Job 1
   └─ generates terraform.tfstate
        └─ upload-artifact → stored in GitHub cloud
Workflow Job 2 / Another Workflow
   └─ download-artifact → retrieved to runner
        └─ terraform destroy uses state file
