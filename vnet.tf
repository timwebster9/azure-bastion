# VNET
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.0.0.0&mask=16&division=25.fff0000
resource "azurerm_virtual_network" "bastion_vnet" {
  name                = "bastion-vnet"
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name
  address_space       = [var.vnet_address_space]
}

# SUBNETS
resource "azurerm_subnet" "bastion_sn" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.bastion.name
  virtual_network_name = azurerm_virtual_network.bastion_vnet.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

resource "azurerm_subnet" "host_sn" {
  name                 = "host-sn"
  resource_group_name  = azurerm_resource_group.bastion.name
  virtual_network_name = azurerm_virtual_network.bastion_vnet.name
  address_prefixes     = [var.host_subnet_cidr]
}





