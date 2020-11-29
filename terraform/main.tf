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
  ssh_public_key = var.ssh_public_key
  ssh_private_key = var.ssh_private_key
  sshd_public_key = var.sshd_public_key
  sshd_private_key = var.sshd_private_key
  storage_box_url = var.storage_box_url
}

module "dagon" {
  source = "./modules/dagon"

  name = "dagon"
  fqdn = "dagon.cloud.dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = var.ssh_public_key
  ssh_private_key = var.ssh_private_key
  sshd_public_key = var.sshd_public_key
  sshd_private_key = var.sshd_private_key
}
