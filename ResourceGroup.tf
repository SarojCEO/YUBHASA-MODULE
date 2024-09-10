variable "var_pharma" {}

resource "azurerm_resource_group" "rg_pharma" {
for_each=var.var_pharma
name=each.value.rg_name
location=each.value.zone
} 
