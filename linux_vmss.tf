resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {
  name                = "linux-vm"
  resource_group_name = azurerm_resource_group.bastion.name
  location            = azurerm_resource_group.bastion.location
  sku                 = "Standard_B2s"
  instances           = 1
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    #public_key = tls_private_key.ssh.public_key_openssh
    public_key = data.local_file.ssh_public_key.content
  }

  network_interface {
    name    = "linux-vmss-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.host_sn.id
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  #source_image_id = var.allowed_source_image_id

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}