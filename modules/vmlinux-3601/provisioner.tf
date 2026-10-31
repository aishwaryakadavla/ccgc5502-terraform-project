resource "null_resource" "display_hostname" {
  for_each = azurerm_linux_virtual_machine.linux

  triggers = {
    vm_id = each.value.id
  }

  connection {
    type     = "ssh"
    host     = azurerm_public_ip.linux[each.key].ip_address
    user     = var.vm_admin_username
    password = var.vm_admin_password
    timeout  = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Linux VM hostname:'",
      "hostname"
    ]
  }
}
