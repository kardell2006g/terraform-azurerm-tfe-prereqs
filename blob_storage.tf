#-------------------------------------------------------------------------------------------
# "Bootstrap" Storage Account
#-------------------------------------------------------------------------------------------
resource "azurerm_storage_account" "bootstrap" {
  resource_group_name             = azurerm_resource_group.tfe_prereqs.name
  location                        = azurerm_resource_group.tfe_prereqs.location
  name                            = "${var.friendly_name_prefix}tfebootstrap"
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = var.network_default_action
    ip_rules                   = var.sa_ingress_cidr_allow
    virtual_network_subnet_ids = [azurerm_subnet.vm.id]
  }

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}tfebootstrap" },
    var.common_tags
  )
}

resource "azurerm_storage_container" "bootstrap" {
  name                  = "bootstrap"
  storage_account_name  = azurerm_storage_account.bootstrap.name
  container_access_type = "private"
}

#-------------------------------------------------------------------------------------------
# "Log Forwarding" Storage Account
#-------------------------------------------------------------------------------------------
resource "azurerm_storage_account" "logging" {
  count = var.deploy_logging_bucket == true ? 1 : 0

  resource_group_name             = azurerm_resource_group.tfe_prereqs.name
  location                        = azurerm_resource_group.tfe_prereqs.location
  name                            = "${var.friendly_name_prefix}tfelogging"
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = var.network_default_action
    ip_rules                   = var.sa_ingress_cidr_allow
    virtual_network_subnet_ids = [azurerm_subnet.vm.id]
  }

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}tfelogging" },
    var.common_tags
  )
}

resource "azurerm_storage_container" "logging" {
  count = var.deploy_logging_bucket == true ? 1 : 0

  name                  = "logging"
  storage_account_name  = azurerm_storage_account.logging[0].name
  container_access_type = "private"
}
