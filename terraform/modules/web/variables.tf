variable "name" {
  description = "Machine name"
  type = string
}

variable "zone" {
  description = "DNS zone"
  type = string
}

variable "passwd" {
  description = "UNIX password hash for cloud user"
  type = string
}

variable "ssh_public_key" {
  description = "Path to SSH public key"
  type = string
}

variable "ssh_private_key" {
  description = "Path to SSH private key"
  type = string
}

variable "sshd_public_key" {
  description = "Path to SSH server public key"
  type = string
}

variable "sshd_private_key" {
  description = "Path to SSH server private key"
  type = string
}

variable "storage_box_url" {
  description = "URL to storage box share"
  type = string
}
