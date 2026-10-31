output "windows_vm_hostname" {
  description = "Hostname of the Windows VM"
  value       = azurerm_windows_virtual_machine.windows[0].computer_name
}

output "windows_vm_domain_name" {
  description = "Fully qualified DNS name of the Windows VM"
  value       = azurerm_public_ip.windows[0].fqdn
}

output "windows_vm_private_ip" {
  description = "Private IP address of the Windows VM"
  value       = azurerm_network_interface.windows[0].private_ip_address
}

output "windows_vm_public_ip" {
  description = "Public IP address of the Windows VM"
  value       = azurerm_public_ip.windows[0].ip_address
}

output "windows_vm_id" {
  description = "ID of the Windows virtual machine"
  value       = azurerm_windows_virtual_machine.windows[0].id
}
