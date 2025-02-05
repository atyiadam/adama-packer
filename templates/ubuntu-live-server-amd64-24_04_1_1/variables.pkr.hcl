variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "ssh_username" {
  type = string
}

variable "ssh_private_key" {
  type = string
}

variable "ssh_timeout" {
  type = string
}

variable "vlan_tag" {
  type = string
}

variable "cloud_init_dir" {
  type = string
}

variable "datasource_order_dir" {
  type = string
}

variable "datasource_order_file" {
  type = string
}

