# Public IP Outputs
## Public IP Address
output "linuxvm_public_ip" {
  description = "Linux VM Public Address"
  value       = azurerm_public_ip.linuxvm_publicip.ip_address
}

# Linux VM Outputs
## Virtual Machine Public IP
output "linuxvm_public_ip_address" {
  description = "Linux Virtual Machine Public IP"
  value       = azurerm_linux_virtual_machine.linuxvm.public_ip_address
}