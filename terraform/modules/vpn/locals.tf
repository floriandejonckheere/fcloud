locals {
  fqdn = "${var.name}.cloud.${var.zone}"
  cloud_init = templatefile("${path.module}/default.tmpl.yml", {
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    fqdn = local.fqdn,
    hostname = var.name,
    passwd = var.passwd,
    swarm_host = var.swarm_host,
    swarm_token = var.swarm_token,
  })
}
