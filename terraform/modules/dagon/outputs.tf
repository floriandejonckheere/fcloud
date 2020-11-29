output "private_ipv4" {
  value = scaleway_instance_server.default.private_ip
}

output "public_ipv4" {
  value = scaleway_instance_ip.default.address
}
