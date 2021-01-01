##
# Services
#
module "web" {
  source = "./modules/web"

  name = "web"
  zone = "dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/web.pub"
  ssh_private_key = "~/.ssh/web"
  sshd_public_key = "~/.ssh/web-sshd.pub"
  sshd_private_key = "~/.ssh/web-sshd"
  storage_box_url = var.storage_box_url
}

module "vpn" {
  source = "./modules/vpn"

  name = "vpn"
  zone = "dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/vpn.pub"
  ssh_private_key = "~/.ssh/vpn"
  sshd_public_key = "~/.ssh/vpn-sshd.pub"
  sshd_private_key = "~/.ssh/vpn-sshd"
  swarm_host = module.web.public_ipv4
  swarm_token = module.web.worker_token
}

module "minecraft" {
  source = "./modules/minecraft"

  enabled = var.minecraft

  name = "minecraft"
  zone = "dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/minecraft.pub"
  ssh_private_key = "~/.ssh/minecraft"
  sshd_public_key = "~/.ssh/minecraft-sshd.pub"
  sshd_private_key = "~/.ssh/minecraft-sshd"
  swarm_host = module.web.public_ipv4
  swarm_token = module.web.worker_token
}
