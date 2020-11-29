locals {
  cloud_init = templatefile("master.tmpl.yml", {
    ssh_public_key = file(var.ssh_public_key),
    sshd_public_key = file(var.sshd_public_key),
    sshd_private_key = file(var.sshd_private_key),
    fqdn = var.fqdn,
    hostname = var.hostname,
    passwd = var.passwd,
    docker_compose = file("docker-compose.yml"),
  })
}

resource "scaleway_account_ssh_key" "master" {
  name = var.hostname
  public_key = file(var.ssh_public_key)
}

resource "scaleway_instance_ip" "master" {
  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_ip_reverse_dns" "master" {
  ip_id = scaleway_instance_ip.master.id
  reverse = var.fqdn
}

resource "scaleway_instance_volume" "master" {
  type = "b_ssd"
  name = "master"
  size_in_gb = 1

  lifecycle {
    prevent_destroy = true
  }
}

resource "scaleway_instance_server" "master" {
  name = var.hostname
  type = "STARDUST1-S"
  image = "debian_buster"
  ip_id = scaleway_instance_ip.master.id
  cloud_init = local.cloud_init

  additional_volume_ids = [
    scaleway_instance_volume.master.id
  ]
}
