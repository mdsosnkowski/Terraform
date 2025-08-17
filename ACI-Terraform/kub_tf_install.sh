#!/bin/bash
# LAB Terraform to Create a Kubernetes Deployment
#
# Update linux
sudo yum update
# Change to directory
cd lab-deploy-kubernetes/
# Create cluster
kind create cluster --name lab-terraform-kubernetes --config  kind-config.yaml
# Get info of Host ip, Certificates
kubectl cluster-info --context kind-lab-terraform-kubernetes > info.txt
#
