resource "azurerm_network_interface" "nic_vm" {
    for_each = var.var_nic
    name=each.value.nic_name
    resource_group_name = each.value.rg_name
    location = each.value.zone

    ip_configuration {
      name=each.value.ip_configuration.ipc_name
      subnet_id= data.azurerm_subnet.data_vm[each.key].id
      private_ip_address_allocation=each.value.ip_configuration.pip_alc
      public_ip_address_id= data.azurerm_public_ip.pip_data[each.key].id
  
}
}

data "azurerm_subnet" "data_vm" {
  name                 = "mainkindsnet"
  virtual_network_name = "mainkindvvnet"
  resource_group_name  = "mainkind"
}

data "azurerm_public_ip" "pip_data" {
    name = "mainkindpip"
    resource_group_name = "mainkind"
  
}