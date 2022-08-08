variable "service_account_key_file" {
  description = "Path to the Yandex.Cloud service account key file"
}

variable "service_account_id" {
  description = "Yandex.Cloud service account ID"
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
}

variable "gitlab_disk_image" {
  description = "Disk image for Gitlab VM"
  default     = "fd8s2gbn4d5k2rcf12d9"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "ansible_inventory" {
  description = "Path to the Ansible inventory file to generate"
  default     = "../ansible/inventory"
}

variable "bucket_name" {
  description = "tfstate storage bucket name"
  default     = "otus-vshender-testenv-tfstate-storage"
}
