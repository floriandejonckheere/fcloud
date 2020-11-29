output "server_ip" {
  value = hcloud_server.default.ipv4_address
}

output "floating_ip" {
  value = hcloud_floating_ip.default.ip_address
}
