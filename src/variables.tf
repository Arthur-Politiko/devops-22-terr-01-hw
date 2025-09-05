variable "yc_token" {
  type        = string
  description = "Yandex Cloud OAuth token"
  default = "Empty"
  sensitive   = false
}

variable "yc_sa_file" {
  type        = string
  description = "Yandex Service account file"
  default = "Empty"
  sensitive   = false
}

variable "cloud_id" {
    #description = "cloud-demagorn"
    type = string
    default = "Empty"
}

variable "folder_id" {
    #description = "folder-tf"
    type = string
    default = "Empty"
}

variable "yc_net_name" {
  type        = string
  default = "nettf"
}

variable "yc_subnet_name" {
  type        = string
  default = "subnet1"
}

variable "yc_zone" {
  type        = string
  default = "ru-central1-a"
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key contents"
  default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_private_key" {
  type        = string
  description = "SSH private key contents"
  default = "~/.ssh/id_ed25519"
}