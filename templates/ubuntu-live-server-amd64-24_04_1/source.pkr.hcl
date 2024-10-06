source "proxmox-iso" "ubuntu-live-server-amd64-24_04_1" {

  proxmox_url = var.proxmox_api_url
  username = var.proxmox_api_token_id
  token = var.proxmox_api_token_secret
  insecure_skip_tls_verify = true

  node = "proxmox-pve-01"
  vm_id = "900"
  vm_name = "ubuntu-live-server-amd64-24.04.1"
  template_description = "Ubuntu Server Template"
  
  boot_iso {
    type = "scsi"
    iso_file = "local:iso/ubuntu-24.04.1-live-server-amd64.iso"
    iso_checksum = "e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9"
    unmount = true
  }

  qemu_agent = true
  scsi_controller = "virtio-scsi-pci"

  disks {
    format = "raw"
    disk_size = "20G"
    storage_pool = "local-lvm"
    type = "virtio"
  }

  cores = "1"
  memory = "1024"

  network_adapters {
    model = "virtio"
    bridge = "vmbr0"
    vlan_tag = var.vlan_tag
    firewall = true
  }

  cloud_init = true
  cloud_init_storage_pool = "local-lvm"

  boot_command = [
      "e",
      "<down><down><down><end>",
      "<left><left><left><left>",
      "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
      "--- <f10>"
  ]
  boot = "c"
  boot_wait = "10s"

  http_directory = var.cloud_init_dir 
  
  ssh_username = var.ssh_username
  ssh_private_key_file = var.ssh_private_key
  ssh_timeout = var.ssh_timeout
}

build {

  name = "ubuntu-live-server-amd64-24_04_1"
  sources = ["source.proxmox-iso.ubuntu-live-server-amd64-24_04_1"]

  provisioner "shell" {
      inline = [
        "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
        "sudo rm /etc/ssh/ssh_host_*",
        "sudo truncate -s 0 /etc/machine-id",
        "sudo apt-get -y autoremove --purge",
        "sudo apt-get -y clean",
        "sudo apt-get -y autoclean",
        "sudo cloud-init clean",
        "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
        "sudo sync"
      ]
  }

  provisioner "file" {
      source = "${var.datasource_order_dir}/${var.datasource_order_file}"
      destination = "/tmp/99-pve.cfg"
  }

  provisioner "shell" {
      inline = [ "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg" ]
  }

}
