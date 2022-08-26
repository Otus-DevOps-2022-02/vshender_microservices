output "env_external_ip" {
  value = yandex_compute_instance.testenv.network_interface[0].nat_ip_address
}
