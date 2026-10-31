variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the Windows VM"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the Windows VM"
  type        = string
}

variable "vm_admin_username" {
  description = "Administrator username for the Windows VM"
  type        = string
}

variable "vm_admin_password" {
  description = "Administrator password for the Windows VM"
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
