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
  server_type = var.server_type
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
    ignore_changes = [size]
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
