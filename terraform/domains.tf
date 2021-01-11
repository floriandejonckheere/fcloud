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
    "sync",
    "cloud",
    "keycloak",
    "dashboard",
    "ldap",
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
