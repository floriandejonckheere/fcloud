##
# Backend
#
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
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
