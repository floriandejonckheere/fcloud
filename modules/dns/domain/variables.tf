variable "zone" {
  description = "DNS zone"
  type = string
}

variable "autorenew" {
  description = "Autorenew domain"
  type = bool

  default = true
}

variable "ipv4_address" {
  description = "IPv4 address"
  type = string
}

variable "domain_contact" {
  description = "Domain contact"
  type = map(string)
}

variable "domain_contact_extra" {
  description = "Domain contact extra parameters"
  type = map(string)

  default = {}
}

variable "dkim" {
  description = "DKIM domain key"
  type = string
}

variable "gsf" {
  description = "Google site verification key"
  type = string

  default = ""
}

variable "subdomains" {
  description = "Subdomain records"
  type = list(string)

  default = []
}
