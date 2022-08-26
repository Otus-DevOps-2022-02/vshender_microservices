resource "yandex_storage_bucket" "tfstate_storage" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key

  # non-empty bucket can be deleted
  force_destroy = "true"
}

resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = var.service_account_id
  description        = "static access key for object storage"
}
