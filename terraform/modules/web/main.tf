locals {
  fqdn = "${var.name}.cloud.${var.zone}"
  cloud_init = templatefile("${path.module}/default.tmpl.yml", {
    ip_address = hcloud_floating_ip.default.ip_address,
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    fqdn = local.fqdn,
    hostname = var.name,
    passwd = var.passwd,
    default_volume = hcloud_volume.default.linux_device,
    storage_box_url: var.storage_box_url,
  })
}

##
# Authentication
#
resource "hcloud_ssh_key" "default" {
  name = var.name
  public_key = file(var.ssh_public_key)
}

##
# Instances
#
resource "hcloud_server" "default" {
  name = var.name
  location = "fsn1"
  image = "debian-10"
  server_type = "cx11"
  ssh_keys = [hcloud_ssh_key.default.id]
  user_data = local.cloud_init
  backups = false

  labels = {
    swarm_manager = true
  }
}

##
# Volumes
#
resource "hcloud_volume" "default" {
  name = var.name
  location = "fsn1"
  size = 10
  format = "ext4"

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_volume_attachment" "default" {
  volume_id = hcloud_volume.default.id
  server_id = hcloud_server.default.id
}

##
# Network
#
resource "hcloud_rdns" "default4" {
  server_id = hcloud_server.default.id
  ip_address = hcloud_server.default.ipv4_address
  dns_ptr = local.fqdn
}

resource "hcloud_rdns" "default6" {
  server_id = hcloud_server.default.id
  ip_address = hcloud_server.default.ipv6_address
  dns_ptr = local.fqdn
}

resource "hcloud_network" "default" {
  name = var.name
  ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "default" {
  network_id = hcloud_network.default.id
  type = "server"
  network_zone = "eu-central"
  ip_range = "10.0.1.0/24"
}

resource "hcloud_server_network" "default" {
  server_id = hcloud_server.default.id
  network_id = hcloud_network.default.id
  ip = "10.0.1.1"
}

resource "hcloud_floating_ip" "default" {
  name = var.name
  home_location = "fsn1"
  type = "ipv4"

  lifecycle {
    prevent_destroy = true
  }
}

resource "hcloud_floating_ip_assignment" "default" {
  floating_ip_id = hcloud_floating_ip.default.id
  server_id = hcloud_server.default.id
}

resource "hcloud_rdns" "floating_default" {
  floating_ip_id = hcloud_floating_ip.default.id
  ip_address = hcloud_floating_ip.default.ip_address
  dns_ptr = local.fqdn
}

module "ipv4_domain" {
  source = "../dns/record"

  zone = var.zone
  name = "${var.name}.cloud"
  type = "A"
  values = [hcloud_floating_ip.default.ip_address]
}

module "ipv6_domain" {
  source = "../dns/record"

  zone = var.zone
  name = "${var.name}.cloud"
  type = "AAAA"
  values = [hcloud_server.default.ipv6_address]
}

##
# Swarm
#
module "manager_token" {
  source = "matti/resource/shell"
  command = "docker swarm join-token --quiet manager"

  environment = {
    DOCKER_HOST = "ssh://cloud@${local.fqdn}"
  }

  depends = [
    hcloud_server.default
  ]
}

module "worker_token" {
  source = "matti/resource/shell"
  command = "docker swarm join-token --quiet manager"

  environment = {
    DOCKER_HOST = "ssh://cloud@${local.fqdn}"
  }

  depends = [
    hcloud_server.default
  ]
}
