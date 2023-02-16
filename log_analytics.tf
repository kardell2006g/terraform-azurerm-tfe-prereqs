resource "azurerm_log_analytics_workspace" "logging" {
  count = var.deploy_log_analytics_workspace == true ? 1 : 0

  name                = "${var.friendly_name_prefix}tfelogging"
  location            = azurerm_resource_group.tfe_prereqs.location
  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_workspace_retention
}
