resource "azurerm_linux_virtual_machine" "pharma_vm" {
    for_each = var.var_vm
    name=each.value.vm_name
    resource_group_name=each.value.rg_name
    location=each.value.zone
    size                            = each.value.size
  admin_username                  = data.azurerm_key_vault_secret.username.value
  admin_password                  = data.azurerm_key_vault_secret.password.value
  disable_password_authentication = each.value.dpa
  network_interface_ids           = [data.azurerm_network_interface.nic_data.id]

os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

data "azurerm_key_vault" "vault_vm" {
  name                = "mainkindvault"
  resource_group_name = "mainkind_vault"
}

data "azurerm_key_vault_secret" "username" {
  name         = "mainkindadmin" # "need to create in cloud portal"
  key_vault_id = data.azurerm_key_vault.vault_vm.id
}

data "azurerm_key_vault_secret" "password" {
  name         = "mainkindpass"  # "need to create in cloud portal"
  key_vault_id = data.azurerm_key_vault.vault_vm.id
}

data "azurerm_network_interface" "nic_data" {
    name = "mainkindnic"
    resource_group_name = "mainkind"
  
}