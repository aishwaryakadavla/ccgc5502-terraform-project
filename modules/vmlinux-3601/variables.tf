variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for Linux VMs"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for Linux VM network interfaces"
  type        = string
}

variable "vm_admin_username" {
  description = "Administrator username for Linux VMs"
  type        = string
}

variable "vm_admin_password" {
  description = "Administrator password for Linux VMs"
  type        = string
  sensitive   = true
}

variable "storage_account_name" {
  description = "Storage account for boot diagnostics"
  type        = string
}

variable "tags" {
  description = "Common project tags"
  type        = map(string)
}
