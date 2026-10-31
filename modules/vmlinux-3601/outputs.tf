output "linux_vm_hostnames" {
  description = "Hostnames of the three Linux VMs"
  value       = [for vm in azurerm_linux_virtual_machine.linux : vm.computer_name]
}

output "linux_vm_fqdns" {
  description = "Fully qualified domain names of the Linux VMs"
  value       = [for pip in azurerm_public_ip.linux : pip.fqdn]
}

output "linux_vm_private_ips" {
  description = "Private IP addresses of the Linux VMs"
  value       = [for nic in azurerm_network_interface.linux : nic.private_ip_address]
}

output "linux_vm_public_ips" {
  description = "Public IP addresses of the Linux VMs"
  value       = [for pip in azurerm_public_ip.linux : pip.ip_address]
}

output "linux_vm_ids" {
  description = "IDs of the three Linux virtual machines"
  value       = { for name, vm in azurerm_linux_virtual_machine.linux : name => vm.id }
}

output "linux_nic_ids" {
  description = "IDs of the three Linux network interfaces"
  value       = { for name, nic in azurerm_network_interface.linux : name => nic.id }
}
