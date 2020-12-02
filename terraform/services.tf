##
# Services
#
module "web" {
  source = "./modules/web"

  name = "web"
  zone = "dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/thalarion.pub"
  ssh_private_key = "~/.ssh/thalarion"
  sshd_public_key = "~/.ssh/thalarion-sshd.pub"
  sshd_private_key = "~/.ssh/thalarion-sshd"
  storage_box_url = var.storage_box_url
}

module "vpn" {
  source = "./modules/vpn"

  name = "vpn"
  zone = "dejonckhee.re"
  passwd = var.passwd
  ssh_public_key = "~/.ssh/dagon.pub"
  ssh_private_key = "~/.ssh/dagon"
  sshd_public_key = "~/.ssh/dagon-sshd.pub"
  sshd_private_key = "~/.ssh/dagon-sshd"
}
