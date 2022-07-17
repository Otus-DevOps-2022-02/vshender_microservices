terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.73.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "reddit_app" {
  count = var.app_instance_count

  name = "reddit-app-${count.index}"

  labels = {
    tags = "reddit-app"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "local_file" "generate_ansible_inventory" {
  filename = var.ansible_inventory
  content = templatefile("files/inventory.tftpl", {
    app_vms = yandex_compute_instance.reddit_app[*]
  })

  provisioner "local-exec" {
    command = "chmod a-x ${self.filename}"
  }

  provisioner "local-exec" {
    when       = destroy
    command    = "mv ${self.filename} ${self.filename}.backup"
    on_failure = continue
  }
}
