output "private_ipv4" {
  value = var.enabled ? hcloud_server.default[0].ipv4_address : null
}

output "private_ipv6" {
  value = var.enabled ? hcloud_server.default[0].ipv6_address : null
}

output "public_ipv4" {
  value = var.enabled ? hcloud_server.default[0].ipv4_address : null
}
