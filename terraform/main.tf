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

##
# Modules
#
module "thalarion" {
  source = "./modules/thalarion"

  name = "thalarion"
  fqdn = "thalarion.cloud.dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/thalarion.pub"
  ssh_private_key = "~/.ssh/thalarion"
  sshd_public_key = "~/.ssh/thalarion-sshd.pub"
  sshd_private_key = "~/.ssh/thalarion-sshd"
  storage_box_url = var.storage_box_url
}

module "dagon" {
  source = "./modules/dagon"

  name = "dagon"
  fqdn = "dagon.cloud.dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/dagon.pub"
  ssh_private_key = "~/.ssh/dagon"
  sshd_public_key = "~/.ssh/dagon-sshd.pub"
  sshd_private_key = "~/.ssh/dagon-sshd"
}
