locals {
  vm_ids = merge(
    var.linux_vm_ids,
    {
      windows = var.windows_vm_id
    }
  )

  vm_zones = {
    "linux-1" = "1"
    "linux-2" = "2"
    "linux-3" = "3"
  }
}

resource "azurerm_managed_disk" "data" {
  for_each = local.vm_ids

  name                 = "3601-${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10

  zone = lookup(local.vm_zones, each.key, null)

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "attachment" {
  for_each = local.vm_ids

  managed_disk_id    = azurerm_managed_disk.data[each.key].id
  virtual_machine_id = each.value
  lun                = 0
  caching            = "ReadWrite"
}
