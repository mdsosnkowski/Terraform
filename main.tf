terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"


    }
  }
}


# Configure the provider with your Cisco APIC credentials.
provider "aci" {
  # APIC Username
  username = var.user.username
  # APIC Password
  password = var.user.password
  # APIC URL
  url      = var.user.url
  insecure = true
}


# Define an ACI Tenant Resource.
resource "aci_tenant" "terraform_tenant" {
    name        = "A-MIKE-PROD-645345"
    description = "This tenant is created by Mike with terraform"
}


# Define an ACI Tenant VRF Resource.
resource "aci_vrf" "terraform_vrf" {
    tenant_dn   = aci_tenant.terraform_tenant.id
    description = "VRF Created Using Terraform"
    name        = "Production"
}
resource "aci_bridge_domain" "prodbridge_domain" {
     tenant_dn                   = aci_tenant.terraform_tenant.id
     description                 = "production bridge domain"
     name                        = "prod_bd"
}


resource "aci_subnet" "sub-vl-456" {
    parent_dn        = aci_bridge_domain.prodbridge_domain.id
    description      = "TEST"
    ip               = "172.22.0.254/24"
}    


resource "aci_subnet" "sub-vl-967" {
    parent_dn      = aci_bridge_domain.prodbridge_domain.id
    description    = "DB-HR-timesheets"
    ip             = "10.10.22.254/24"
}
