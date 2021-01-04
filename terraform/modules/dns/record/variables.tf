variable "zone" {
  description = "DNS zone"
  type = string
}

variable "name" {
  description = "DNS record name"
  type = string
}

variable "type" {
  description = "DNS record type"
  type = string
}

variable "ttl" {
  description = "DNS record TTL"
  type = number

  default = 1800
}

variable "values" {
  description = "DNS record values"
  type = list(string)
}
