##
# dejonckhee.re
#
module "dejonckhee_re" {
  source = "./modules/dns/domain"

  zone = "dejonckhee.re"
  ipv4_address = module.web.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "dejonckhee_re")
  gsf = lookup(var.gsf, "dejonckhee_re")
}

module "florian_dejonckheere_be" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "florian"
  type = "CNAME"
  values = ["dejonckhee.re."]
}

module "traefik_dejonckhee_re" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "traefik"
  type = "CNAME"
  values = ["dejonckhee.re."]
}

module "vault_dejonckhee_re" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "vault"
  type = "CNAME"
  values = ["dejonckhee.re."]
}

module "trivial_dejonckhee_re" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "trivial"
  type = "CNAME"
  values = ["dejonckhee.re."]
}

module "sync_dejonckhee_re" {
  source = "./modules/dns/record"

  zone = "dejonckhee.re"
  name = "sync"
  type = "CNAME"
  values = ["dejonckhee.re."]
}

##
# floriandejonckheere.be
#
module "floriandejonckheere_be" {
  source = "./modules/dns/domain"

  zone = "floriandejonckheere.be"
  ipv4_address = module.web.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "floriandejonckheere_be")
  gsf = lookup(var.gsf, "floriandejonckheere_be")
}

module "www_floriandejonckheere_be" {
  source = "./modules/dns/record"

  zone = "floriandejonckheere.be"
  name = "www"
  type = "CNAME"
  values = ["floriandejonckheere.be."]
}

##
# headbang.re
#
module "headbang_re" {
  source = "./modules/dns/domain"

  zone = "headbang.re"
  ipv4_address = module.web.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "headbang_re")
  gsf = lookup(var.gsf, "headbang_re")
}

module "www_headbang_re" {
  source = "./modules/dns/record"

  zone = "headbang.re"
  name = "www"
  type = "CNAME"
  values = ["headbang.re."]
}
