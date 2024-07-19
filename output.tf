output "core_vm_ips" {
  value = azurerm_public_ip.corepubip.*.ip_address
}

output "core_vm_dns" {
  value = azurerm_public_ip.corepubip.*.fqdn
}

