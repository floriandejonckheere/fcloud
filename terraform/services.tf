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
}
