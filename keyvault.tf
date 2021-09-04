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
}