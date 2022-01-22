##
# Subdomain
#
resource "gandi_livedns_record" "default" {
  zone = var.zone
  name = var.name
  type = var.type
  values = var.values
  ttl = var.ttl
}
