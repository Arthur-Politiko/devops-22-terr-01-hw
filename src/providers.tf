terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }

    yandex = {
      source = "yandex-cloud/yandex"
    }

  }

  #Требуемая версия terraform 
  required_version = ">=1.8.4"
}

# # Initialize provider
# provider "docker" {
#   alias = "remote"
#   host = "ssh://ubuntu@${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}:22"
#   ssh_opts = [
#     "-i", var.ssh_private_key,
#     "-o", "StrictHostKeyChecking=no",
#     "-o", "UserKnownHostsFile=/dev/null"    
#   ]
# }

# Initialize provider
provider "yandex" {
  # https://terraform-provider.yandexcloud.net//
  #token     = var.yc_token
  #service_account_key_file = "../key/key.json" #ar.yc_sa_file  
  service_account_key_file = var.yc_sa_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.yc_zone  
}


