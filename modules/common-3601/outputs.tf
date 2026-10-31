output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.workspace.name
}

output "recovery_vault_name" {
  description = "Name of the Recovery Services vault"
  value       = azurerm_recovery_services_vault.vault.name
}

output "storage_account_name" {
  description = "Name of the storage account used for VM diagnostics"
  value       = azurerm_storage_account.diagnostics.name
}

output "storage_account_id" {
  description = "ID of the storage account used for VM diagnostics"
  value       = azurerm_storage_account.diagnostics.id
}
