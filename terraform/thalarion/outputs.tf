output "server_ip" {
  value = hcloud_server.master.ipv4_address
}

output "floating_ip" {
  value = hcloud_floating_ip.master.ip_address
}
