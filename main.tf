locals {
  common_tags = {
    Project        = "CCGC 5502 Terraform Project"
    Name           = "Aishwarya.Kadavla"
    ExpirationDate = "2027-12-31"
    Environment    = "Learning"
  }
}

module "resource_group" {
  source = "./modules/rgroup-3601"

  resource_group_name = "rg-3601-project"
  location            = "eastus"
  tags                = local.common_tags
}

module "network" {
  source = "./modules/network-3601"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  vnet_name               = "3601-VNET"
  vnet_address_space      = ["10.0.0.0/16"]
  subnet_name             = "3601-SUBNET"
  subnet_address_prefixes = ["10.0.1.0/24"]
  nsg_name                = "3601-NSG"

  tags = local.common_tags
}

module "common" {
  source = "./modules/common-3601"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  log_analytics_name   = "3601-law"
  recovery_vault_name  = "rsv-3601-recovery-vault"
  storage_account_name = "st3601commonak26"

  tags = local.common_tags
}

module "vmlinux" {
  source = "./modules/vmlinux-3601"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  subnet_id           = module.network.subnet_id

  vm_admin_username = "azureadmin"
  vm_admin_password = var.vm_admin_password

  storage_account_name = module.common.storage_account_name

  tags = local.common_tags
}

module "vmwindows" {
  source = "./modules/vmwindows-3601"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  subnet_id           = module.network.subnet_id

  vm_admin_username = "azureadmin"
  vm_admin_password = var.vm_admin_password

  storage_account_name = module.common.storage_account_name

  tags = local.common_tags
}

module "datadisk" {
  source = "./modules/datadisk-3601"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  linux_vm_ids  = module.vmlinux.linux_vm_ids
  windows_vm_id = module.vmwindows.windows_vm_id

  tags = local.common_tags
}

module "loadbalancer" {
  source = "./modules/loadbalancer-3601"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  linux_nic_ids = module.vmlinux.linux_nic_ids

  tags = local.common_tags
}

module "database" {
  source = "./modules/database-3601"

  resource_group_name = module.resource_group.resource_group_name
  location            = "canadacentral"

  server_name            = "psql-3601-project-ak26"
  administrator_login    = "pgadmin3601"
  administrator_password = var.vm_admin_password

  tags = local.common_tags
}
