
global_settings = {
  tags = {
    Environment = "Test"
  }

}

resource_name     = "narendr"
resource_group_name = "narendra-rg"
resource_location = "eastus"

vnet_prefix           = "10.50.0.0/16"
subnet_core_prefix    = "10.30.1.0/24"

core_vm_type        = "Standard_D4s_v5"
core_vm_count       = 1
core_vm_osdisk_type = "StandardSSD_LRS"
core_vm_osdisk_size = "32"


core_vm_password = ""
