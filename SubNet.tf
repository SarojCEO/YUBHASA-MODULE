resource "azurerm_subnet" "snet_vnet" {
    for_each = var.var_snet
    name=each.value.snet_name
    resource_group_name = each.value.rg_name
    virtual_network_name = each.value.vnet_name
    address_prefixes = each.value.ip_snet
}
