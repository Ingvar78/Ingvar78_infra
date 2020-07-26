terraform {
  # Версия terraform
  required_version = " ~> 0.12.8"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
  db_ip           = module.db.internal_ip_address_db
  postfix_name    = var.postfix_name
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
  postfix_name    = var.postfix_name
}

module "vpc" {
  source         = "../modules/vpc"
  postfix_name   = var.postfix_name
  v4_cidr_blocks = var.v4_cidr_blocks
  network_id     = var.network_id
}
