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

resource "yandex_kubernetes_cluster" "reddit_k8s" {
  name = "reddit-k8s"

  network_id = yandex_vpc_network.reddit_network.id

  master {
    version = var.k8s_version

    public_ip = true

    zonal {
      zone      = yandex_vpc_subnet.reddit_subnet.zone
      subnet_id = yandex_vpc_subnet.reddit_subnet.id
    }

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        start_time = "04:00"
        duration   = "3h"
      }
    }
  }

  service_account_id      = var.service_account_id
  node_service_account_id = var.node_service_account_id

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"
}

resource "yandex_kubernetes_node_group" "reddit_k8s_node_group" {
  name = "reddit-k8s-node-group"

  cluster_id = yandex_kubernetes_cluster.reddit_k8s.id
  version    = var.k8s_version

  instance_template {
    platform_id = "standard-v1"

    network_interface {
      nat        = true
      subnet_ids = [yandex_vpc_subnet.reddit_subnet.id]
    }

    resources {
      memory = var.node_memory
      cores  = var.node_cores
    }

    boot_disk {
      type = "network-ssd"
      size = var.node_disk_size
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }

    metadata = {
      ssh-keys = "ubuntu:${file(var.public_key_path)}"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.nodes_number
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      start_time = "04:00"
      duration   = "3h"
    }
  }
}

resource "yandex_vpc_network" "reddit_network" {
  name = "reddit-network"
}

resource "yandex_vpc_subnet" "reddit_subnet" {
  name           = "reddit-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.reddit_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
  - cluster:
      server: ${yandex_kubernetes_cluster.reddit_k8s.master[0].external_v4_endpoint}
      certificate-authority-data: ${base64encode(yandex_kubernetes_cluster.reddit_k8s.master[0].cluster_ca_certificate)}
    name: yc-managed-k8s-${yandex_kubernetes_cluster.reddit_k8s.id}
contexts:
  - context:
      cluster: yc-managed-k8s-${yandex_kubernetes_cluster.reddit_k8s.id}
      user: yc-managed-k8s-${yandex_kubernetes_cluster.reddit_k8s.id}
    name: yc-${yandex_kubernetes_cluster.reddit_k8s.name}
current-context: yc-${yandex_kubernetes_cluster.reddit_k8s.name}
kind: Config
preferences: {}
users:
  - name: yc-managed-k8s-${yandex_kubernetes_cluster.reddit_k8s.id}
    user:
      exec:
        apiVersion: client.authentication.k8s.io/v1beta1
        args:
          - k8s
          - create-token
          - --profile=default
        command: yc
        env: null
        interactiveMode: IfAvailable
        provideClusterInfo: false
KUBECONFIG
}
