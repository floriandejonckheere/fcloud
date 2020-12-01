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

variable "values" {
  description = "DNS record values"
  type = list(string)
}
