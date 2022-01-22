##
# Domain
#
data "gandi_livedns_domain_ns" "default" {
  name = var.zone
}

resource "gandi_domain" "default" {
  name = var.zone
  autorenew = var.autorenew
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

  lifecycle {
    ignore_changes = [
      admin,
      billing,
      owner,
      tech,
    ]
  }
}

resource "gandi_livedns_domain" "default" {
  name = var.zone
  ttl = 0
  automatic_snapshots = true
}

module "a" {
  source = "../record"

  zone = var.zone
  name = "@"
  type = "A"
  values = [var.ipv4_address]
}

module "caa" {
  source = "../record"

  zone = var.zone
  name = "@"
  type = "CAA"
  values = ["0 issue \"letsencrypt.org\""]
}

module "mx" {
  source = "../record"

  zone = var.zone
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

module "dkim" {
  source = "../record"

  zone = var.zone
  name = "google._domainkey"
  type = "TXT"
  values = ["\"${var.dkim}\""]
}

module "dmarc" {
  source = "../record"

  zone = var.zone
  name = "_dmarc"
  type = "TXT"
  values = ["\"v=DMARC1; p=quarantine\""]
}

module "spf" {
  source = "../record"

  zone = var.zone
  name = "@"
  type = "TXT"
  values = [
    "\"v=spf1 include:_spf.google.com ~all\"",
    "\"google-site-verification=${var.gsf}\""
  ]
}

module "subdomains" {
  source = "../record"

  for_each = {for subdomain in var.subdomains:  subdomain => subdomain}

  zone = var.zone
  name = each.value
  type = "CNAME"
  values = ["${var.zone}."]
}
