locals {
  linux_vms = {
    linux-1 = {
      zone = "1"
    }
    linux-2 = {
      zone = "2"
    }
    linux-3 = {
      zone = "3"
    }
  }
}

resource "azurerm_public_ip" "linux" {
  for_each = local.linux_vms

  name                = "3601-${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "aish-3601-${each.key}"

  zones = [each.value.zone]

  tags = var.tags
}

resource "azurerm_network_interface" "linux" {
  for_each = local.linux_vms

  name                = "3601-${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux[each.key].id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux" {
  for_each = local.linux_vms

  name                = "3601-${each.key}"
  computer_name       = each.key
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2as_v4"
  zone                = each.value.zone

  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.linux[each.key].id
  ]

  os_disk {
    name                 = "3601-${each.key}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  boot_diagnostics {
    storage_account_uri = "https://${var.storage_account_name}.blob.core.windows.net/"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each = local.linux_vms

  name                       = "NetworkWatcherAgentLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.linux[each.key].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  tags = var.tags
}
