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
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "app_instance_count" {
  description = "Number of the application VM instances to create"
  type        = number
  default     = 1
}

variable "ansible_inventory" {
  description = "Path to the Ansible inventory file to generate"
  default     = "../ansible/inventory"
}
