output "k8s_master_external_ip" {
  value = yandex_compute_instance.k8s_master.network_interface[0].nat_ip_address
}

output "k8s_worker_external_ip" {
  value = yandex_compute_instance.k8s_worker.network_interface[0].nat_ip_address
}
