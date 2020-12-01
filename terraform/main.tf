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

##
# Domains
#
module "dejonckhee_re" {
  source = "./modules/dns/domain"

  zone = "dejonckhee.re"
  # FIXME: uncomment when cloud migration is complete
  ipv4_address = "168.119.155.79" #module.web.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "dejonckhee_re")
  gsf = lookup(var.gsf, "dejonckhee_re")
}

module "floriandejonckheere_be" {
  source = "./modules/dns/domain"

  zone = "floriandejonckheere.be"
  # FIXME: uncomment when cloud migration is complete
  ipv4_address = "168.119.155.79" #module.web.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "floriandejonckheere_be")
  gsf = lookup(var.gsf, "floriandejonckheere_be")
}

module "headbang_re" {
  source = "./modules/dns/domain"

  zone = "headbang.re"
  # FIXME: uncomment when cloud migration is complete
  ipv4_address = "168.119.155.79" #module.web.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "headbang_re")
  gsf = lookup(var.gsf, "headbang_re")
}

##
# Services
#
module "web" {
  source = "./modules/web"

  name = "web"
  fqdn = "web.cloud.dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/thalarion.pub"
  ssh_private_key = "~/.ssh/thalarion"
  sshd_public_key = "~/.ssh/thalarion-sshd.pub"
  sshd_private_key = "~/.ssh/thalarion-sshd"
  storage_box_url = var.storage_box_url
}

module "vpn" {
  source = "./modules/vpn"

  name = "vpn"
  zone = "dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/dagon.pub"
  ssh_private_key = "~/.ssh/dagon"
  sshd_public_key = "~/.ssh/dagon-sshd.pub"
  sshd_private_key = "~/.ssh/dagon-sshd"
}
