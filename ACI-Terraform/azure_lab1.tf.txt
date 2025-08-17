# LAB 1 - Deploy Azure VNETs and Subnets with Terraform
# Download from GitHub your config into the Cloud space on Azure
# Download Terraform: wget https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip
# Unzip terraform: unzip terraform_1.0.8_linux_amd64
# Need to get the Resource Group name and put it in below
# Make Subnets then subdivide

provider "azurerm" {
    version = 1.38
    }

# Create virtual network
resource "azurerm_virtual_network" "lab1" {
    name                = "prod1"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = "Enter Resource Group Name"

    tags = {
        environment = "Terraform Networking"
    }
}

# Create subnet
resource "azurerm_subnet" "prod1sub1" {
    name                 = "LabSubnet"
    resource_group_name = "Enter Resource Group Name"
    virtual_network_name = azurerm_virtual_network.lab1.name
    address_prefix       = "10.0.1.0/24"
}
resource "azurerm_subnet" "prod1sub2" {
    name                 = "LabSubnet2"
    resource_group_name = "Enter Resource Group Name"
    virtual_network_name = azurerm_virtual_network.lab1.name
    address_prefix       = "10.0.2.0/24"
}


### ADD IN MORE SUBNETS


### CHANGE ADDRESS SPACE
