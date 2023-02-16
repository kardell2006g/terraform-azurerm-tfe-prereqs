#------------------------------------------------------------------------------
# AzureRM Client Config
#------------------------------------------------------------------------------
data "azurerm_client_config" "current" {}

#------------------------------------------------------------------------------
# Key Vault
#------------------------------------------------------------------------------
resource "azurerm_key_vault" "tfe_bootstrap_kv" {
  resource_group_name        = azurerm_resource_group.tfe_prereqs.name
  location                   = azurerm_resource_group.tfe_prereqs.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  name                       = "${var.friendly_name_prefix}-tfe-kv"
  enabled_for_deployment     = true
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  network_acls {
    bypass                     = "AzureServices"
    default_action             = var.network_default_action
    ip_rules                   = var.kv_ingress_cidr_allow
    virtual_network_subnet_ids = [azurerm_subnet.vm.id]
  }

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-tfe-kv" },
    var.common_tags
  )
}

resource "azurerm_key_vault_access_policy" "kv_access" {
  key_vault_id = azurerm_key_vault.tfe_bootstrap_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Restore",
    "Backup",
    "Recover",
    "Delete",
    "Import",
    "Create",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Purge",
  ]

  certificate_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "ManageContacts",
    "DeleteIssuers",
    "SetIssuers",
    "ListIssuers",
    "ManageIssuers",
    "GetIssuers",
  ]
}

#------------------------------------------------------------------------------
# Key Vault Secrets
#------------------------------------------------------------------------------
resource "azurerm_key_vault_secret" "console_password" {
  count = var.kv_console_password != null ? 1 : 0

  key_vault_id = azurerm_key_vault.tfe_bootstrap_kv.id
  name         = "console-password"
  value        = var.kv_console_password

  tags = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.kv_access]
}

resource "azurerm_key_vault_secret" "enc_password" {
  count = var.kv_enc_password != null ? 1 : 0

  key_vault_id = azurerm_key_vault.tfe_bootstrap_kv.id
  name         = "enc-password"
  value        = var.kv_enc_password

  tags = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.kv_access]
}

resource "azurerm_key_vault_secret" "tfe_cert" {
  count = var.kv_tfe_cert_b64 != null ? 1 : 0

  key_vault_id = azurerm_key_vault.tfe_bootstrap_kv.id
  name         = "tfe-cert"
  value        = var.kv_tfe_cert_b64

  tags = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.kv_access]
}

resource "azurerm_key_vault_secret" "tfe_privkey" {
  count = var.kv_tfe_privkey_b64 != null ? 1 : 0

  key_vault_id = azurerm_key_vault.tfe_bootstrap_kv.id
  name         = "tfe-privkey"
  value        = var.kv_tfe_privkey_b64

  tags = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.kv_access]
}

resource "azurerm_key_vault_secret" "ca_bundle" {
  count = var.kv_ca_bundle != null ? 1 : 0

  key_vault_id = azurerm_key_vault.tfe_bootstrap_kv.id
  name         = "ca-bundle"
  value        = var.kv_ca_bundle

  tags = var.common_tags

  depends_on = [azurerm_key_vault_access_policy.kv_access]
}
