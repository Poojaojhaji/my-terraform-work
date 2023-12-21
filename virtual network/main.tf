resource "azurerm_virtual_network" "virtual_network" {
  for_each            = var.v_network
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  subnet {

    name           = each.value.subnetname
    address_prefix = each.value.address_prefix
  }

}