variable "postfix_name" {
  description = "Postfix to name of enviroment"
  default     = ""
}
variable "v4_cidr_blocks" {
  description = "v4_cidr_block for env"
  default     = ["192.168.1.0/24"]
}
variable network_id {
  description = "Network ID"
}
