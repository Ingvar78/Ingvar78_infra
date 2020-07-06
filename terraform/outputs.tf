# Основные инстансы (1-3)
output "external_ip_address_app-1" {
  value = yandex_compute_instance.app[0].network_interface.0.nat_ip_address
}
output "external_ip_address_app-2" {
  value = yandex_compute_instance.app[1].network_interface.0.nat_ip_address
}
output "external_ip_address_app-3" {
  value = yandex_compute_instance.app[2].network_interface.0.nat_ip_address
}

# Балансер
output "reddit-balancer-address" {
  value = yandex_lb_network_load_balancer.reddit-lb.listener.*.external_address_spec.0.address
}
