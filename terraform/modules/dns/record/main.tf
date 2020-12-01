##
# Subdomain
#
resource "gandi_livedns_record" "default" {
  zone = var.zone
  name = var.name
  type = var.type
  ttl = 10800
  values = var.values
}
