#Create NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.resource_name}-nsg"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  tags                = var.global_settings.tags
}

#Create NSG Rules
resource "azurerm_network_security_rule" "PORT_22" {
  name                        = "PORT_22"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.nsg_allowed_ips
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "PORT_27017" {
  name                        = "PORT_27017"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "27017"
  source_address_prefixes     = var.nsg_allowed_ips
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

#Associate subnet to NSG
resource "azurerm_subnet_network_security_group_association" "core_nsg_subnet" {
  subnet_id                 = azurerm_subnet.core-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
