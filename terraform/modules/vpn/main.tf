locals {
  fqdn = "${var.name}.cloud.${var.zone}"
  cloud_init = templatefile("${path.module}/default.tmpl.yml", {
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    fqdn = local.fqdn,
    hostname = var.name,
    passwd = var.passwd,
  })
}

##
# Authentication
#
resource "scaleway_account_ssh_key" "default" {
  name = var.name
  public_key = file(var.ssh_public_key)
}

##
# Instances
#
resource "scaleway_instance_server" "default" {
  name = var.name
  type = "STARDUST1-S"
  image = "debian_buster"
  enable_dynamic_ip = false
  ip_id = scaleway_instance_ip.default.id
  enable_ipv6 = true
  cloud_init = local.cloud_init

  additional_volume_ids = [
    scaleway_instance_volume.default.id
  ]

  tags = [
    "swarm_worker",
  ]

  lifecycle {
    ignore_changes = [user_data]
  }
}

##
# Volumes
#
resource "scaleway_instance_volume" "default" {
  type = "b_ssd"
  name = var.name
  size_in_gb = 1

  lifecycle {
    prevent_destroy = true
  }
}

##
# Network
#
resource "scaleway_instance_ip" "default" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_ip_reverse_dns" "default" {
  ip_id = scaleway_instance_ip.default.id
  reverse = local.fqdn
}

module "ipv4_domain" {
  source = "../dns/record"

  zone = var.zone
  name = "${var.name}.cloud"
  type = "A"
  values = [scaleway_instance_server.default.public_ip]
}

module "ipv6_domain" {
  source = "../dns/record"

  zone = var.zone
  name = "${var.name}.cloud"
  type = "AAAA"
  values = [scaleway_instance_server.default.ipv6_address]
}
