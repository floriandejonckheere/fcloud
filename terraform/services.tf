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

  # Type    vCPU  RAM   Price/h  Price/mo
  # cx11    1     2G    0.005/h   3.01/mo
  # cpx11   2     2G    0.007/h   4.22/mo
  # cx21    2     4G    0.010/h   5.93/mo
  # cpx21   3     4G    0.013/h   8.35/mo
  # cx31    2     8G    0.017/h  10.77/mo
  # cpx31   4     8G    0.024/h  15.00/mo
  # cx41    4    16G    0.031/h  19.24/mo
  # cpx41   8    16G    0.046/h  27.71/mo
  # cx51    8    32G    0.061/h  36.18/mo
  # cpx51   16   32G    0.097/h  60.38/mo
  server_type = "cx21"
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
  network_id = module.web.network_id

  # Type    vCPU  RAM   Price/h  Price/mo
  # cx11    1     2G    0.005/h   3.01/mo
  # cpx11   2     2G    0.007/h   4.22/mo
  # cx21    2     4G    0.010/h   5.93/mo
  # cpx21   3     4G    0.013/h   8.35/mo
  # cx31    2     8G    0.017/h  10.77/mo
  # cpx31   4     8G    0.024/h  15.00/mo
  # cx41    4    16G    0.031/h  19.24/mo
  # cpx41   8    16G    0.046/h  27.71/mo
  # cx51    8    32G    0.061/h  36.18/mo
  # cpx51   16   32G    0.097/h  60.38/mo
  #
  # Don't forget to adjust the MEMORY variable in `../swarm/minecraft/docker-compose.yml`
  server_type = "cpx41"
}
