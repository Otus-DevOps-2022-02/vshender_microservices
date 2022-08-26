variable "oauth_token" {
  description = "Yandex.Cloud OAuth token"
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

variable "disk_image" {
  description = "Disk image for Gitlab VM"
  default     = "fd8s2gbn4d5k2rcf12d9"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}

variable "private_key_path" {
  description = "Path to the private key used for ssh access"
  default     = "~/.ssh/appuser"
}

variable "envname" {
  description = "Name of the environment"
}
