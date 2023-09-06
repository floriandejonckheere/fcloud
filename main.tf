##
# Terraform configuration
#
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    gandi = {
      source = "psychopenguin/gandi"
      version = "2.0.0-rc3"
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
  key = var.gandi_key
}
