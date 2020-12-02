##
# Backend
#
terraform {
  backend "s3" {
    bucket = "thalarion-tfstate"
    key = "terraform.tfstate"
    region = "nl-ams"
    endpoint = "https://s3.nl-ams.scw.cloud"

    skip_credentials_validation = true
    skip_region_validation = true
  }
}

##
# Provider
#
provider "hcloud" {
  token = var.hcloud_token
}

provider "scaleway" {
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
  organization_id = var.scaleway_organization_id
  zone = "nl-ams-1"
  region = "nl-ams"
}

provider "gandi" {
  key = var.gandi_key
}
