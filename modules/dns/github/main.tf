##
# Domain
#
data "gandi_livedns_domain_ns" "default" {
  name = var.zone
}

resource "gandi_domain" "default" {
  name = var.zone
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
  values = ["185.199.108.153", "185.199.109.153", "185.199.110.153", "185.199.111.153"]
}

module "aaaa" {
  source = "../record"

  zone = var.zone
  name = "@"
  type = "AAAA"
  values = ["2606:50c0:8000::153", "2606:50c0:8001::153", "2606:50c0:8002::153", "2606:50c0:8003::153"]
}

module "cname" {
  source = "../record"

  zone = var.zone
  name = "www"
  type = "CNAME"
  values = [var.cname]
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
