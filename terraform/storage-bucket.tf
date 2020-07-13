provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  # key_id, secret
  storage_access_key = var.storage_access_key
  storage_secret_key = var.storage_secret_key
}


resource "yandex_storage_bucket" "ingvar78" {
  bucket = "ingvar78"
}
