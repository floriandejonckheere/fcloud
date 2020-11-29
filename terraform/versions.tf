terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}
