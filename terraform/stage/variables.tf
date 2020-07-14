variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}
variable service_account_key_file {
  description = "terraform service account key .json"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable subnet_id {
  description = "subnet id"
}
variable public_key_path {
  description = "public key path"
}
variable private_key_path {
  description = "private key path"
}
variable app_instances_count {
  description = "instances count"
  default     = 1
}
