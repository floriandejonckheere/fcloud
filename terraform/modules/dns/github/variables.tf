variable "zone" {
  description = "DNS zone"
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

variable "cname" {
  description = "CNAME domain"
  type = string
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
