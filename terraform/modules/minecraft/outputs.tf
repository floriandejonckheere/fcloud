output "private_ipv4" {
  value = hcloud_server.default.ipv4_address
}

output "private_ipv6" {
  value = hcloud_server.default.ipv6_address
}

output "public_ipv4" {
//  value = hcloud_floating_ip.default.ip_address
  value = hcloud_server.default.ipv4_address
}
