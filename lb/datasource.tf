data "azurerm_public_ip" "public_ip" {
  name                = "linuxpip"
  resource_group_name = "pooja_resourcegroup"
}

data "azurerm_virtual_network" "vnet" {
  name                = "pooja_v_network"
  resource_group_name = "pooja_resourcegroup"
}


