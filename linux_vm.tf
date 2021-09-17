resource "azurerm_network_interface" "host_vm" {
  name                = "linux-vm-nic"
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.host_sn.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "linux-host-vm"
  resource_group_name = azurerm_resource_group.bastion.name
  location            = azurerm_resource_group.bastion.location
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.host_vm.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    #public_key = tls_private_key.ssh.public_key_openssh
    public_key = data.local_file.ssh_public_key.content
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# 20.04
# "publisher": "canonical",
# "offer": "0001-com-ubuntu-server-focal",
# "sku": "20_04-lts",
# "version": "latest"