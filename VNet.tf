resource "azurerm_virtual_network" "vnet_vm" {
    for_each=var.var_vnet
    name=each.value.vnet_name
    location = each.value.zone
    resource_group_name = each.value.rg_name
    address_space = each.value.ip_range
}