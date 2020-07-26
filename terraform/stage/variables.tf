variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable image_id {
  description = "Disk image"
}
variable subnet_id {
  description = "Subnet"
}
variable network_id {
  description = "Network ID"
}
variable service_account_key_file {
  description = "key .json"
}
variable private_key_path {
  description = "Path to Private Key File"
}
variable app_instances_count {
  description = "instances count"
  default     = 1
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable vCores_count {
  description = "vCores count"
  default     = 2
}
variable memory_size {
  description = "Memory RAM in GB"
  default     = 2
}
variable storage_access_key {
  description = "access_key id"
}
variable storage_secret_key {
  description = "secret key"
}
variable storage_sa_id {
  description = "SERVICE ACCOUNT ID"
}
variable "postfix_name" {
  description = "Postfix to name of enviroment"
  default     = ""
}
variable "v4_cidr_blocks" {
  description = "v4_cidr_block for env"
  default     = ["10.10.1.0/24"]
}
