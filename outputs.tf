output "resource_group_name" {
  description = "Name of the project resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_location" {
  description = "Location of the project resource group"
  value       = module.resource_group.resource_group_location
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.network.vnet_name
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = module.network.subnet_name
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = module.common.log_analytics_workspace_name
}

output "recovery_vault_name" {
  description = "Name of the Recovery Services vault"
  value       = module.common.recovery_vault_name
}

output "storage_account_name" {
  description = "Name of the common storage account"
  value       = module.common.storage_account_name
}

output "linux_vm_hostnames" {
  description = "Hostnames of the three Linux VMs"
  value       = module.vmlinux.linux_vm_hostnames
}

output "linux_vm_fqdns" {
  description = "Fully qualified domain names of the Linux VMs"
  value       = module.vmlinux.linux_vm_fqdns
}

output "linux_vm_private_ips" {
  description = "Private IP addresses of the Linux VMs"
  value       = module.vmlinux.linux_vm_private_ips
}

output "linux_vm_public_ips" {
  description = "Public IP addresses of the Linux VMs"
  value       = module.vmlinux.linux_vm_public_ips
}

output "windows_vm_hostname" {
  description = "Hostname of the Windows VM"
  value       = module.vmwindows.windows_vm_hostname
}

output "windows_vm_domain_name" {
  description = "Fully qualified domain name of the Windows VM"
  value       = module.vmwindows.windows_vm_domain_name
}

output "windows_vm_private_ip" {
  description = "Private IP address of the Windows VM"
  value       = module.vmwindows.windows_vm_private_ip
}

output "windows_vm_public_ip" {
  description = "Public IP address of the Windows VM"
  value       = module.vmwindows.windows_vm_public_ip
}

output "load_balancer_name" {
  description = "Name of the Load Balancer"
  value       = module.loadbalancer.load_balancer_name
}

output "postgres_server_name" {
  description = "Name of the PostgreSQL Flexible Server"
  value       = module.database.postgres_server_name
}

output "postgres_server_fqdn" {
  description = "Fully qualified domain name of the PostgreSQL server"
  value       = module.database.postgres_server_fqdn
}
