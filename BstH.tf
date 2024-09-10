variable "bsth_var" {}

resource "azurerm_bastion_host" "pharma_bsth" {
    for_each = var.bsth_var
  name                = each.value.bsth_name
  location            = each.value.zone
  resource_group_name = each.value.rg_name

  ip_configuration {
    name                 = each.value.ip_configuration.bsth_ipc_name
    subnet_id            = data.azurerm_subnet.data_svm[each.key].id
    public_ip_address_id = data.azurerm_public_ip.spip_data[each.key].id
  }
}

data "azurerm_subnet" "data_svm" {
  name                 = "mainkindsdnet"
  virtual_network_name = "mainkindvvnet"
  resource_group_name  = "mainkind"
}

data "azurerm_public_ip" "spip_data" {
    name = "mainkindsdpip"
    resource_group_name = "mainkind"
  
}