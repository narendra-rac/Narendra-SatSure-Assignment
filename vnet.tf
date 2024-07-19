# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_name}-vnet"
  address_space       = [var.vnet_prefix]
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  tags                = var.global_settings.tags
}