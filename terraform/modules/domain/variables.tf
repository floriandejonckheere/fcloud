variable "fqdn" {
  description = "Fully qualified domain name"
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
