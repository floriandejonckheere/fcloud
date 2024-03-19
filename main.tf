##
# Terraform configuration
#
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    gandi = {
      source = "go-gandi/gandi"
    }
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
  required_version = ">= 0.13"
}

##
# Provider
#
provider "hcloud" {
  token = var.hcloud_token
}

provider "gandi" {
  personal_access_token = var.gandi_key
}
