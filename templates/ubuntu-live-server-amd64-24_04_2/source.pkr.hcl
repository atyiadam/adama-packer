source "proxmox-iso" "ubuntu-live-server-amd64-24_04_2" {

  proxmox_url              = var.proxmox_api_url
  username                 = var.proxmox_api_token_id
  token                    = var.proxmox_api_token_secret
  insecure_skip_tls_verify = true

  node                 = var.node
  vm_id                = var.vm_id
  vm_name              = "ubuntu-live-server-amd64-24.04.2"
  template_description = "Ubuntu Server Template"

  boot_iso {
    type         = "scsi"
    iso_file     = "local:iso/ubuntu-24.04.2-live-server-amd64.iso"
    unmount      = true
  }

  qemu_agent      = true
  scsi_controller = "virtio-scsi-pci"

  disks {
    format       = "raw"
    disk_size    = "100G"
    storage_pool = "local-lvm"
    type         = "virtio"
  }

  cores  = "2"
  memory = "2048"

  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    vlan_tag = var.vlan_tag
    firewall = true
  }

  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"

  boot_command = [
    "e",
    "<down><down><down><end>",
    "<left><left><left><left>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "--- <f10>"
  ]
  boot      = "c"
  boot_wait = "10s"

  http_directory = var.cloud_init_dir

  ssh_username         = var.ssh_username
  ssh_private_key_file = var.ssh_private_key
  ssh_timeout          = var.ssh_timeout
}

