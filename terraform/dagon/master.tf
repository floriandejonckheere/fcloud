locals {
  cloud_init = templatefile("master.tmpl.yml", {
    ip_address = scaleway_instance_ip.master.address,
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    domain_name = var.domain_name,
    hostname = var.hostname,
    passwd = var.passwd,
  })
}

output "cloud_init" {
  value = local.cloud_init
}

provider "scaleway" {
  access_key = var.scaleway_access_key
  secret_key = var.scaleway_secret_key
  organization_id = var.scaleway_organization_id
  zone = "nl-ams-1"
  region = "nl-ams"
}

resource "scaleway_account_ssh_key" "master" {
  name = "Dagon"
  public_key = file(var.ssh_public_key)
}

resource "scaleway_instance_ip" "master" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_ip_reverse_dns" "master" {
  ip_id = scaleway_instance_ip.master.id
  reverse = var.domain_name
}

resource "scaleway_instance_volume" "master" {
  type = "b_ssd"
  name = "master"
  size_in_gb = 1

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_server" "master" {
  name = "dagon"
  type = "STARDUST1-S"
  image = "debian_buster"
  ip_id = scaleway_instance_ip.master.id
  cloud_init = local.cloud_init

  additional_volume_ids = [
    scaleway_instance_volume.master.id
  ]
}
