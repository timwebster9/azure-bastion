# RG
resource "azurerm_resource_group" "bastion" {
  name     = "bastion-rg"
  location = var.location
}