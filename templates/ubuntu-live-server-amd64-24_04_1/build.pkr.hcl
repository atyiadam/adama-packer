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
