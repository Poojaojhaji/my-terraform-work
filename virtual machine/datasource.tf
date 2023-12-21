data "azurerm_subnet" "subnet_data" {
  name                 = "subnet11"
  virtual_network_name = "pooja_v_network"
  resource_group_name  = "pooja_resourcegroup"
}
