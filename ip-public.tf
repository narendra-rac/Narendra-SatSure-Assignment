resource "azurerm_public_ip" "corepubip" {
  count               = var.core_vm_count
  name                = format("%s-corevm%d-ip", var.resource_name, count.index + 1)
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  # public_ip_prefix_id = azurerm_public_ip_prefix.public_ip_prefix.id
  domain_name_label   = format("%scorevm%d", var.resource_name, count.index + 1)
  tags                = var.global_settings.tags
}
