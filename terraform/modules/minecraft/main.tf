locals {
  fqdn = "${var.name}.cloud.${var.zone}"
  cloud_init = templatefile("${path.module}/default.tmpl.yml", {
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    fqdn = local.fqdn,
    hostname = var.name,
    passwd = var.passwd,
    default_volume = hcloud_volume.default.linux_device,
    swarm_host = var.swarm_host,
    swarm_token = var.swarm_token,
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
  count = var.enabled ? 1 : 0

  name = var.name
  location = "fsn1"
  image = "debian-10"
  server_type = "cx11"
  ssh_keys = [hcloud_ssh_key.default.id]
  user_data = local.cloud_init
  backups = false

  labels = {
    swarm_worker = true
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
  count = var.enabled ? 1 : 0

  volume_id = hcloud_volume.default.id
  server_id = hcloud_server.default[0].id
}

##
# Network
#
resource "hcloud_rdns" "default4" {
  count = var.enabled ? 1 : 0

  server_id = hcloud_server.default[0].id
  ip_address = hcloud_server.default[0].ipv4_address
  dns_ptr = local.fqdn
}

resource "hcloud_rdns" "default6" {
  count = var.enabled ? 1 : 0

  server_id = hcloud_server.default[0].id
  ip_address = hcloud_server.default[0].ipv6_address
  dns_ptr = local.fqdn
}

resource "hcloud_server_network" "default" {
  count = var.enabled ? 1 : 0

  server_id = hcloud_server.default[0].id
  network_id = var.network_id
}

module "ipv4_domain" {
  source = "../dns/record"

  count = var.enabled ? 1 : 0

  zone = var.zone
  name = "${var.name}.cloud"
  type = "A"
  values = [hcloud_server.default[0].ipv4_address]
  ttl = 300

  depends_on = [
    hcloud_server.default,
  ]
}

module "ipv6_domain" {
  source = "../dns/record"

  count = var.enabled ? 1 : 0

  zone = var.zone
  name = "${var.name}.cloud"
  type = "AAAA"
  values = [hcloud_server.default[0].ipv6_address]
  ttl = 300
}
