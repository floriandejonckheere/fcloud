variable "scaleway_access_key" {
  type = string
}
variable "scaleway_secret_key" {
  type = string
}

variable "scaleway_organization_id" {
  type = string
}

variable "passwd" {
  description = "UNIX password hash for cloud user"
  type = string
}

variable "fqdn" {
  description = "Fully qualified domain name"
  type = string
}

variable "hostname" {
  description = "Machine hostname"
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
