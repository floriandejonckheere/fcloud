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
  datacenter = "hel1-dc2"
  image = "debian-11"
  server_type = var.server_type
  ssh_keys = [hcloud_ssh_key.default.id]
  user_data = local.cloud_init
  backups = false
  firewall_ids = [hcloud_firewall.default.id]

  public_net {
    ipv4 = hcloud_primary_ip.default4.id
    ipv6 = hcloud_primary_ip.default6.id
  }

  lifecycle {
    ignore_changes = [
      user_data,
    ]
  }
}

##
# Volumes
#
resource "hcloud_volume" "default" {
  name = var.name
  location = "hel1"
  size = 10
  format = "ext4"
  delete_protection = true

  lifecycle {
    prevent_destroy = true
    ignore_changes = [size]
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
}

resource "hcloud_primary_ip" "default4" {
  name = "${var.name}4"
  type = "ipv4"
  datacenter = "hel1-dc2"
  assignee_type = "server"
  auto_delete = false
}

resource "hcloud_primary_ip" "default6" {
  name = "${var.name}6"
  type = "ipv6"
  datacenter = "hel1-dc2"
  assignee_type = "server"
  auto_delete = false
}

module "ipv4_domain" {
  source = "../dns/record"

  zone = var.zone
  name = var.name
  type = "A"
  values = [hcloud_primary_ip.default4.ip_address]
}

module "ipv6_domain" {
  source = "../dns/record"

  zone = var.zone
  name = var.name
  type = "AAAA"
  values = [hcloud_primary_ip.default6.ip_address]
}

module "wildcard_domain" {
  source = "../dns/record"

  zone = var.zone
  name = "*.${var.name}"
  type = "CNAME"
  values = ["${local.fqdn}."]
}

##
# Firewall
#
resource "hcloud_firewall" "default" {
  name = "default"

  # Ping
  rule {
    direction = "in"
    protocol = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  # SSH
  rule {
    direction = "in"
    protocol = "tcp"
    port = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol = "tcp"
    port = "22"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  # HTTP/HTTPS
  rule {
    direction = "in"
    protocol = "tcp"
    port = "80"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "in"
    protocol = "tcp"
    port = "443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol = "tcp"
    port = "80"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol = "tcp"
    port = "443"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  # DNS
  rule {
    direction = "out"
    protocol = "tcp"
    port = "53"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol = "udp"
    port = "53"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  # SMTP
  rule {
    direction = "out"
    protocol = "tcp"
    port = "465"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol = "tcp"
    port = "587"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction = "out"
    protocol = "tcp"
    port = "993"
    destination_ips = ["0.0.0.0/0", "::/0"]
  }

  # WireGuard
  rule {
    direction = "in"
    protocol = "udp"
    port = "51820"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}
