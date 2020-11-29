##
# Domain
#
data "gandi_livedns_domain_ns" "default" {
  name = var.fqdn
}

resource "gandi_domain" "default" {
  name = var.fqdn
  autorenew = true
  nameservers = data.gandi_livedns_domain_ns.default.nameservers

  admin {
    type = "person"

    country = lookup(var.domain_contact, "country")
    email = lookup(var.domain_contact, "email")
    family_name = lookup(var.domain_contact, "family_name")
    given_name = lookup(var.domain_contact, "given_name")
    phone = lookup(var.domain_contact, "phone")
    street_addr = lookup(var.domain_contact, "street_addr")
    city = lookup(var.domain_contact, "city")
    zip = lookup(var.domain_contact, "zip")
    extra_parameters = var.domain_contact_extra

    data_obfuscated = true
    mail_obfuscated = true
  }

  billing {
    type = "person"

    country = lookup(var.domain_contact, "country")
    email = lookup(var.domain_contact, "email")
    family_name = lookup(var.domain_contact, "family_name")
    given_name = lookup(var.domain_contact, "given_name")
    phone = lookup(var.domain_contact, "phone")
    street_addr = lookup(var.domain_contact, "street_addr")
    city = lookup(var.domain_contact, "city")
    zip = lookup(var.domain_contact, "zip")
    extra_parameters = var.domain_contact_extra

    data_obfuscated = true
    mail_obfuscated = true
  }

  owner {
    type = "person"

    country = lookup(var.domain_contact, "country")
    email = lookup(var.domain_contact, "email")
    family_name = lookup(var.domain_contact, "family_name")
    given_name = lookup(var.domain_contact, "given_name")
    phone = lookup(var.domain_contact, "phone")
    street_addr = lookup(var.domain_contact, "street_addr")
    city = lookup(var.domain_contact, "city")
    zip = lookup(var.domain_contact, "zip")
    extra_parameters = var.domain_contact_extra

    data_obfuscated = true
    mail_obfuscated = true
  }

  tech {
    type = "person"

    country = lookup(var.domain_contact, "country")
    email = lookup(var.domain_contact, "email")
    family_name = lookup(var.domain_contact, "family_name")
    given_name = lookup(var.domain_contact, "given_name")
    phone = lookup(var.domain_contact, "phone")
    street_addr = lookup(var.domain_contact, "street_addr")
    city = lookup(var.domain_contact, "city")
    zip = lookup(var.domain_contact, "zip")
    extra_parameters = var.domain_contact_extra

    data_obfuscated = true
    mail_obfuscated = true
  }
}

resource "gandi_livedns_domain" "default" {
  name = var.fqdn
  ttl = 0
  automatic_snapshots = true
}

module "caa" {
  source = "../record"

  fqdn = var.fqdn
  name = "@"
  type = "CAA"
  values = ["0 issue \"letsencrypt.org\""]
}

module "mx" {
  source = "../record"

  fqdn = var.fqdn
  name = "@"
  type = "MX"
  values = [
    "1 aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com."
  ]
}
