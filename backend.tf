terraform {
  backend "azurerm" {
    resource_group_name  = "rg-3601-tfstate"
    storage_account_name = "st3601tfstateak26"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"

    use_cli          = true
    use_azuread_auth = true
    tenant_id        = "ff36de19-f5a7-4a19-b549-6deb7a7cf496"
  }
}
