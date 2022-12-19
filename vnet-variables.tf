## Virtual Network Name
variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "vnet-default"
}

## Virtual Network Address Space
variable "vnet_address_space" {
  description = "Virtual Network Address Space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Subnet Name
variable "subnet_name" {
  description = "Subnet Name"
  type        = string
  default     = "default"
}

# Subnet Address Space
variable "subnet_address" {
  description = "Subnet Address Spaces"
  type        = list(string)
  default     = ["10.0.100.0/24"]
}