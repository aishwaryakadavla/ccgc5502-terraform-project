variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for common resources"
  type        = string
}

variable "log_analytics_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "recovery_vault_name" {
  description = "Name of the Recovery Services vault"
  type        = string
}

variable "storage_account_name" {
  description = "Globally unique name of the storage account"
  type        = string
}

variable "tags" {
  description = "Common project tags"
  type        = map(string)
}
