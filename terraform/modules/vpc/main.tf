resource "yandex_vpc_network" "app-network" {
  name = "infra-net-${var.postfix_name}"
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = "app-subnet-${var.postfix_name}"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.app-network.id}"
  v4_cidr_blocks = var.v4_cidr_blocks
}
