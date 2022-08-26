output "app_vm_ips" {
  value = yandex_compute_instance.reddit_app[*].network_interface[0].nat_ip_address
}
