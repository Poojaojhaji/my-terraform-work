
resource "azurerm_lb" "Loadbalancer" {
  for_each = var.lb
  name                = "pooja-loadbalancer"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backendaddresspool" {
  for_each = var.lb
  loadbalancer_id = azurerm_lb.Loadbalancer[each.key].id
  name            = "BackEndAddressPool"
}

/*resource "azurerm_lb_backend_address_pool_address" "backendaddresspool_address" {
  for_each = var.lb
  name                    = each.value.backendaddresspool_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendaddresspool.id
  virtual_network_id      = data.azurerm_virtual_network.vnet.id
  ip_address              = data.azurerm_virtual_machine.virtualmachine[each.key].private_ip_address
}*/

# resource "azurerm_lb_backend_address_pool_address" "backendaddresspool_address_02" {
#   name                    = "linuxvm02"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backendaddresspool.id
#   virtual_network_id      = data.azurerm_virtual_network.vnet.id
#   ip_address              = data.azurerm_virtual_machine.virtualmachine[each.key].private_ip_address
# }

resource "azurerm_lb_rule" "lbrule" {
  for_each = var.lb
  loadbalancer_id                = azurerm_lb.Loadbalancer[each.key].id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backendaddresspool[each.key].id]
  probe_id = azurerm_lb_probe.lbhealthprobe[each.key].id
}

resource "azurerm_lb_probe" "lbhealthprobe" {
  for_each = var.lb
  loadbalancer_id = azurerm_lb.Loadbalancer[each.key].id
  name            = "http-running-probe"
  port            = 80
}