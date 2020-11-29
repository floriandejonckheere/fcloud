terraform {
  required_providers {
    gandi = {
      source = "psychopenguin/gandi"
      version = "2.0.0-rc3"
    }
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    scaleway = {
      source = "scaleway/scaleway"
    }
  }
  required_version = ">= 0.13"
}
