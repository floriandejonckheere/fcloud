##
# Provider
#
provider "hcloud" {
  token = var.hcloud_token
}

provider "scaleway" {
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
  organization_id = var.scaleway_organization_id
  zone = "nl-ams-1"
  region = "nl-ams"
}
