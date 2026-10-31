resource "azurerm_availability_set" "windows" {
  name                         = "3601-windows-as"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = var.tags
}

resource "azurerm_public_ip" "windows" {
  count = 1

  name                = "3601-windows-pip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "ak3601-win-vm26"

  tags = var.tags
}

resource "azurerm_network_interface" "windows" {
  count = 1

  name                = "3601-windows-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows[count.index].id
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windows" {
  count = 1

  name                = "3601-windows-vm-${count.index + 1}"
  computer_name       = "WIN3601VM"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2as_v4"
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password

  network_interface_ids = [
    azurerm_network_interface.windows[count.index].id
  ]

  availability_set_id = azurerm_availability_set.windows.id

  os_disk {
    name                 = "3601-windows-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  boot_diagnostics {
    storage_account_uri = "https://${var.storage_account_name}.blob.core.windows.net/"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count = 1

  name                       = "IaaSAntimalware"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows[count.index].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.5"
  auto_upgrade_minor_version = true

  tags = var.tags
}
