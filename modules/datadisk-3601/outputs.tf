output "data_disk_ids" {
  description = "IDs of the four managed data disks"
  value       = { for name, disk in azurerm_managed_disk.data : name => disk.id }
}

output "data_disk_names" {
  description = "Names of the four managed data disks"
  value       = { for name, disk in azurerm_managed_disk.data : name => disk.name }
}
