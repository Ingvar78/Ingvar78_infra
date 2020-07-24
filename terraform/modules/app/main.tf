resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = var.vCores_count
    memory = var.memory_size
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    #    subnet_id = yandex_vpc_subnet.app-subnet.id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    host        = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }

#  provisioner "file" {
#    source      = "../files/puma.service"
#    destination = "/tmp/puma.service"
#  }

#  provisioner "remote-exec" {
#    inline = [
#      "echo export DATABASE_URL=${var.db_ip} >> ~/.profile",
#    ]
#  }

#  provisioner "remote-exec" {
#    script = "../files/deploy.sh"
#  }

}
