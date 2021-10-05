#!/bin/bash
# Clone from Git up the terraform docs
# git clone https://github.com/ClarityUnderstanding/terraform.git

# Change to the directory "terraform"
cd terraform

# Download from GitHub your config into the Cloud space on Azure
wget https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip

# Unzip terraform: 
unzip terraform_1.0.8_linux_amd64

# Make a fake main.tf file for basic setup
touch main.tf

# Intialize your installation
./terraform init
