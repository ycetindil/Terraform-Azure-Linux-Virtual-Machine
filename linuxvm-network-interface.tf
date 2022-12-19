resource "azurerm_network_interface" "linuxvm_nic" {
  name                = "${local.resource_name_prefix}-linuxvm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "linuxvm-ip-1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linuxvm_publicip.id
  }
}