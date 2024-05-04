##
# dejonckhee.re
#
module "dejonckhee_re" {
  source = "./modules/dns/domain"

  zone = "dejonckhee.re"
  ipv4_address = module.cloud.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "dejonckhee_re")
  gsf = lookup(var.gsf, "dejonckhee_re")

  subdomains = [
    "*",
  ]
}

module "box_cloud_dejonckhee_re" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "box.cloud"
  type = "CNAME"
  values = [var.additional_domains.box]
}

module "vpn_cloud_dejonckhee_re" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "vpn.cloud"
  type = "A"
  values = [var.additional_domains.vpn]
}

module "_vpn_cloud_dejonckhee_re" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "*.vpn.cloud"
  type = "CNAME"
  values = ["vpn.cloud"]
}

##
# floriandejonckheere.be
#
module "floriandejonckheere_be" {
  source = "./modules/dns/domain"

  zone = "floriandejonckheere.be"
  ipv4_address = module.cloud.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "floriandejonckheere_be")
  gsf = lookup(var.gsf, "floriandejonckheere_be")

  subdomains = [
    "www",
  ]
}

##
# falqon.dev
#
module "falqon_dev" {
  source = "./modules/dns/domain"

  zone = "falqon.dev"
  ipv4_address = module.cloud.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "falqon_dev")
  gsf = lookup(var.gsf, "falqon_dev")

  subdomains = [
    "www",
  ]
}
