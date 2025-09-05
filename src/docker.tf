resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

# Из-за того, что адрес хоста используется в destroy, нельзя использовать переменные которые вычисляются на этом этапе. Только через triggers
# locals {
#   vm_ip_address = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
# }

# locals {
#   ssh_host = "ssh://ubuntu@${local.vm_ip_address}"
# }

resource "terraform_data" "deploy_compose" {
  depends_on = [yandex_compute_instance.vm-1]

  triggers_replace = {
    compose_hash = filesha256("${path.module}/compose.yml")
    #db_password  = sha1(local.mysql_root_password)
    ssh_opts = "-o ConnectTimeout=300 -o StrictHostKeyChecking=no"
    vm_ip_address = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
    ssh_host = "ssh://ubuntu@${yandex_compute_instance.vm-1.network_interface.0.nat_ip_address}"
  }

  provisioner "local-exec" {
    #command = "docker compose up -d"
    # Вот это ssh -q -o StrictHostKeyChecking=no ubuntu@${local.vm_ip_address} 'exit 0' ;
    # нужна, так как terraform не имеет встроенных средств доступа в ВМ и использует ssh. В данном случае "отключаем" защиту MITM
    # sleep 40s  нужен чтобы дождаться пока sshd поднимится, можно сделать красивее, дёргая ssh каждые 10 секунд
    command = "sleep 40s && ssh ${self.triggers_replace.ssh_opts} ubuntu@${self.triggers_replace.vm_ip_address} 'exit 0' && docker -H ${self.triggers_replace.ssh_host} compose up -d --quiet-pull"  
  }

  provisioner "local-exec" {
    when    = destroy
    command = "docker -H ${self.triggers_replace.ssh_host} compose down -v --remove-orphans"
    #command = "docker context list"
  }
}