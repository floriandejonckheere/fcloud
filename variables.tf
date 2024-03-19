##
# Providers
#
variable "hcloud_token" {
  type = string
}

variable "gandi_key" {
  type = string
}

##
# Domains
#
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
  description = "DKIM domain keys"
  type = map(string)
}

variable "gsf" {
  description = "Google site verification keys (only the part after `google-site-verification=`)"
  type = map(string)

  default = {}
}

variable "additional_domains" {
  description = "Additional domains"
  type = map(string)

  default = {}
}

##
# Services
#
variable "passwd" {
  description = "UNIX password hash for cloud user"
  type = string
}

variable "minecraft" {
  description = "Minecraft server enabled/disabled"
  type = bool
  default = false
}
