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

resource "yandex_compute_instance" "gitlab" {
  name = "gitlab"

  resources {
    cores  = 2
    memory = 8
  }

  boot_disk {
    initialize_params {
      size     = 50
      image_id = var.gitlab_disk_image
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
    gitlab_vm = yandex_compute_instance.gitlab
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
