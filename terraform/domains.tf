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

//module "floriandejonckheere_be" {
//  source = "./modules/dns/domain"
//
//  zone = "floriandejonckheere.be"
//  # FIXME: uncomment when cloud migration is complete
//  ipv4_address = "168.119.155.79" #module.web.public_ipv4
//  domain_contact = var.domain_contact
//  domain_contact_extra = var.domain_contact_extra
//  dkim = lookup(var.dkim, "floriandejonckheere_be")
//  gsf = lookup(var.gsf, "floriandejonckheere_be")
//}

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
