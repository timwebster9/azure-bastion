resource "azurerm_key_vault" "bastion_kv" {
  name                        = "bastionkv675674475675"
  location                    = azurerm_resource_group.bastion.location
  resource_group_name         = azurerm_resource_group.bastion.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
  enable_rbac_authorization   = true

#   network_acls {
#       bypass         = "AzureServices"
#       default_action = "Deny"
#       ip_rules       = [""]
#   }
}

/*
resource "azurerm_private_endpoint" "keyvault" {
  name                = "kv-endpoint"
  location            = azurerm_resource_group.bastion.location
  resource_group_name = azurerm_resource_group.bastion.name
  subnet_id           = azurerm_subnet.pe_sn.id

  private_service_connection {
    name                           = "kv-privateserviceconnection"
    private_connection_resource_id = azurerm_key_vault.bastion_kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name = "kvgroup"
    private_dns_zone_ids = [
        azurerm_private_dns_zone.kv.id
    ]
  }
}
*/

resource "azurerm_role_assignment" "sp_kv_role_assignment" {
  scope                = azurerm_key_vault.bastion_kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

/*
resource "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "linux-vm-ssh-key"
  value        = tls_private_key.ssh.private_key_pem
  key_vault_id = azurerm_key_vault.bastion_kv.id

  depends_on = [
      azurerm_role_assignment.sp_kv_role_assignment
  ]
}*/