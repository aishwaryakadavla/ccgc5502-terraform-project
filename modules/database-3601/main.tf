resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  zone                = "1"

  version                = "16"
  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled = true

  tags = var.tags
}
