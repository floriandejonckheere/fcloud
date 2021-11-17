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

  subdomains = [
    "florian",
    "traefik",
    "vault",
    "trivial",
  ]
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

  subdomains = [
    "www",
  ]
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

  subdomains = [
    "www",
    "ma.cache",
    "app",
  ]
}

##
# codered.pm
#
module "codered_pm" {
  source = "./modules/dns/domain"

  zone = "codered.pm"
  ipv4_address = module.web.public_ipv4
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "codered_pm")
  gsf = lookup(var.gsf, "codered_pm")

  subdomains = [
    "www",
  ]
}

##
# kozo.dev
#
module "kozo_dev" {
  source = "./modules/dns/github"

  zone = "kozo.dev"
  cname = "floriandejonckheere.github.io."
  domain_contact = var.domain_contact
  domain_contact_extra = var.domain_contact_extra
  dkim = lookup(var.dkim, "codered_pm")
  gsf = lookup(var.gsf, "codered_pm")
}
