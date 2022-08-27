variable "service_account_key_file" {
  description = "Path to the Yandex.Cloud service account key file"
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

variable "subnet_id" {
  description = "Subnet"
  default     = "e9bqom95bd1o3fkemarr"
}

variable "disk_image_id" {
  description = "Disk image for Gitlab VM"
  default     = "fd8v0s6adqu3ui3rsuap"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "ansible_inventory" {
  description = "Path to the Ansible inventory file to generate"
  default     = "../ansible/inventory"
}
