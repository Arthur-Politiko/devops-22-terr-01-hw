resource "yandex_compute_disk" "boot-disk-1" {
  name     = "boot-disk-1"
  type     = "network-hdd"
  zone     = var.yc_zone
  size     = "20"
  image_id = "fd8esrke14l0tup5l393"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-1.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }
}

resource "yandex_vpc_network" "net1" {
  name = var.yc_net_name
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = var.yc_subnet_name
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.net1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
