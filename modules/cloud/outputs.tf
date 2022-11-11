output "network_id" {
  value = hcloud_network.default.id
}

output "network_ipv4" {
  value = hcloud_server_network.default.ip
}

output "private_ipv4" {
  value = hcloud_server.default.ipv4_address
}

output "private_ipv6" {
  value = hcloud_primary_ip.default6.ip_address
}

output "public_ipv4" {
  value = hcloud_primary_ip.default4.ip_address
}
