variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable vCores_count {
  description = "vCores count"
  default     = 2
}
variable memory_size {
  description = "Memory RAM in GB"
  default     = 2
}

variable service_account_key_file {
  description = "key .json"
  default     = "~/Documents/Otus/yc-cloud/tf_sa_key_file.json"
}

variable private_key_path {
  description = "Path to private key used for ssh access"
  default     = "~/.ssh/ubuntu"
}

variable public_key_path {
  description = "Path to public key used for ssh access"
  default     = "~/.ssh/ubuntu.pub"
}

variable db_ip {
  description = "db ip-address"
}