##
# Providers
#
variable "hcloud_token" {
  type = string
}

variable "scaleway_access_key" {
  type = string
}
variable "scaleway_secret_key" {
  type = string
}

variable "scaleway_organization_id" {
  type = string
}

##
# Modules
#
variable "passwd" {
  description = "UNIX password hash for cloud user"
  type = string
}

variable "storage_box_url" {
  description = "URL to storage box share"
  type = string
}
