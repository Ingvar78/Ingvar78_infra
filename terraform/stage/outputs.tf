#output "external_ip_address_app" {
#  value = module.app.external_ip_address_app
#}
#output "external_ip_address_db" {
#  value = module.db.external_ip_address_db
#}
# for ansible
output "inventory" {
value = <<INVENTORY
{ "_meta": {
        "hostvars": { }
    },
  "app": {
    "hosts": ["${module.app.external_ip_address_app}"]
  },
  "db": {
    "hosts": ["${module.db.external_ip_address_db}"],
    "vars": {
        "private_ip": "${module.db.internal_ip_address_db}"
    }
  }
}
    INVENTORY
}