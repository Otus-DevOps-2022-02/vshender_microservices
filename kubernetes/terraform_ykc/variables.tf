variable "service_account_key_file" {
  description = "Path to the Yandex.Cloud service account key file"
}

variable "service_account_id" {
  description = "Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster"
}

variable "node_service_account_id" {
  description = "Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics."
}


variable "cloud_id" {
  description = "Cloud"
}

variable "folder_id" {
  description = "Folder"
}

variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.19"
}

variable "nodes_number" {
  description = "Number of k8s nodes"
  default     = 1
}

variable "node_cores" {
  description = "Number of cores for k8s node"
  default     = 4
}

variable "node_memory" {
  description = "Amount of memory for k8s node"
  default     = 8
}

variable "node_disk_size" {
  description = "Size of a disk for k8s node"
  default     = 64
}
