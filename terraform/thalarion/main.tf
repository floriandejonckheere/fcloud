locals {
  cloud_init = templatefile("master.tmpl.yml", {
    ip_address = hcloud_floating_ip.master.ip_address,
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    fqdn = var.fqdn,
    hostname = var.hostname,
    passwd = var.passwd,
    master_volume_dev = hcloud_volume.master.linux_device,
    storage_box_url: var.storage_box_url,
  })
}

##
# Provider
#
provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "master" {
  name = var.hostname
  public_key = file(var.ssh_public_key)
}

##
# Instances
#
resource "hcloud_server" "master" {
  name = var.hostname
  location = "fsn1"
  image = "debian-10"
  server_type = "cx11"
  ssh_keys = [hcloud_ssh_key.master.id]
  user_data = local.cloud_init
  backups = false
}

##
# Volumes
#
resource "hcloud_volume" "master" {
  name = "master"
  location = "fsn1"
  size = 10
  format = "ext4"

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_volume_attachment" "master" {
  volume_id = hcloud_volume.master.id
  server_id = hcloud_server.master.id
}

##
# Network
#
resource "hcloud_rdns" "master4" {
  server_id = hcloud_server.master.id
  ip_address = hcloud_server.master.ipv4_address
  dns_ptr = var.fqdn
}

resource "hcloud_rdns" "master6" {
  server_id = hcloud_server.master.id
  ip_address = hcloud_server.master.ipv6_address
  dns_ptr = var.fqdn
}

resource "hcloud_network" "master" {
  name = "master"
  ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "master" {
  network_id = hcloud_network.master.id
  type = "server"
  network_zone = "eu-central"
  ip_range = "10.0.1.0/24"
}

resource "hcloud_floating_ip" "master" {
  name = "master"
  type = "ipv4"

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_floating_ip_assignment" "master" {
  floating_ip_id = hcloud_floating_ip.master.id
  server_id = hcloud_server.master.id
}

resource "hcloud_rdns" "floating_master" {
  floating_ip_id = hcloud_floating_ip.master.id
  ip_address = hcloud_floating_ip.master.ip_address
  dns_ptr = var.fqdn
}