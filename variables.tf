variable "global_settings" {
  description = "Tags to be applied to the resources"
}

variable "resource_name" {
  description = "RID to be used for the retailer"
}

variable "resource_group_name" {
  description = "resource_group_name"
  default = "narendra-rg"
}

variable "resource_location" {
  description = "Location in which the resources needs to be created"
}

variable "vnet_prefix" {
  description = "Address space to be used for the Virtual Network"
}

variable "subnet_core_prefix" {
  description = "Address space to be used for the Subnet of Core VM"
}

variable "nsg_allowed_ips" {
  description = "IP addresses to be whitelisted to connect to the resources"
  default     = []
}
variable "nsg_allowed_ips_kpi" {
  description = "IP addresses to be whitelisted to connect to the resources"
  default     = []
}

variable "core_vm_type" {
  description = ""
}

variable "core_vm_count" {
  description = ""
  type        = number
  default     = 1
}

variable "core_vm_osdisk_type" {
  description = ""
}

variable "core_vm_osdisk_size" {
  description = "Size of the Core VM OS Disk"
  default     = "30"
}

variable "admin" {
  default = "admin"
}

variable "core_vm_password" {
  description = "Password for core vm"
}
