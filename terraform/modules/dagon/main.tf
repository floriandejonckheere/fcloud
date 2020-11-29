locals {
  cloud_init = templatefile("${path.module}/default.tmpl.yml", {
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    fqdn = var.fqdn,
    hostname = var.name,
    passwd = var.passwd,
    docker_compose = file("${path.module}/docker-compose.yml"),
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
  ip_id = scaleway_instance_ip.default.id
  cloud_init = local.cloud_init

  additional_volume_ids = [
    scaleway_instance_volume.default.id
  ]
}

##
# Volumes
#
resource "scaleway_instance_volume" "default" {
  type = "b_ssd"
  name = "default"
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
  reverse = var.fqdn
}
