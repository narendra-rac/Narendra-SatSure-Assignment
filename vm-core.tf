resource "azurerm_network_interface" "corenic" {
  count               = var.core_vm_count
  name                = format("%s-corevm%d-nic", var.resource_name, count.index + 1)
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  tags                = var.global_settings.tags

  ip_configuration {
    name                          = "ipconfiguration"
    subnet_id                     = azurerm_subnet.core-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.subnet_core_prefix, 4 + count.index)
    public_ip_address_id          = azurerm_public_ip.corepubip[count.index].id
  }
}

#Get-AzVMImageSku -Location "North Europe" -PublisherName "Canonical" -Offer "0001-com-ubuntu-server-focal" | Select Skus
resource "azurerm_virtual_machine" "corevm" {
  count                            = var.core_vm_count
  name                             = format("%s-corevm%d", var.resource_name, count.index + 1)
  location                         = var.resource_location
  resource_group_name              = var.resource_group_name
  network_interface_ids            = [azurerm_network_interface.corenic[count.index].id]
  vm_size                          = var.core_vm_type
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  tags                             = var.global_settings.tags
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = format("%s-corevm%d-osdisk", var.resource_name, count.index + 1)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.core_vm_osdisk_type
    disk_size_gb      = var.core_vm_osdisk_size
  }
 
  os_profile {
    computer_name  = format("%s-corevm%d", var.resource_name, count.index + 1)
    admin_username = var.admin
    admin_password = var.core_vm_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
    
  }
}

resource "null_resource" "remote_exec" {
 count                            = var.core_vm_count

  depends_on = [azurerm_virtual_machine.corevm]
   
  connection {
      type        = "ssh"
      host        = azurerm_public_ip.corepubip[count.index].ip_address
      user        = "admin"
      password    = ""
      # If using SSH key authentication, use the private_key argument instead
      # private_key = file("<path_to_private_key>")
    }
  provisioner "file" {
    source      = "setup-k8s-docker-minikube.sh"
    destination = "/home/admin/setup-k8s-docker-minikube.sh"
  }

  provisioner "remote-exec" { 

    inline = [
      "chmod +x /home/admin/setup-k8s-docker-minikube.sh",
      "sudo /home/admin/setup-k8s-docker-minikube.sh"
    ]
  }
}