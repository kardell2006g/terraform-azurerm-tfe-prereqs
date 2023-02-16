resource "azurerm_dns_zone" "public" {
  count = var.public_dns_zone_name != null ? 1 : 0

  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  name                = var.public_dns_zone_name

  tags = merge(
    { "Name" = "${var.public_dns_zone_name}" },
    var.common_tags
  )
}

resource "azurerm_private_dns_zone" "private" {
  count = var.private_dns_zone_name != null ? 1 : 0

  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  name                = var.private_dns_zone_name

  tags = merge(
    { "Name" = "${var.private_dns_zone_name}" },
    var.common_tags
  )
}