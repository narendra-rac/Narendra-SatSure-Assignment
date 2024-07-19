resource "azurerm_subnet" "core-subnet" {
  name                 = format("%s-core-subnet", var.resource_name)
  resource_group_name  = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_core_prefix]
  service_endpoints    = ["Microsoft.EventHub", "Microsoft.Sql", "Microsoft.Storage"]
}

