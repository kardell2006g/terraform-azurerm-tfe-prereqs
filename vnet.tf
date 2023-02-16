#------------------------------------------------------------------------------
# VNet
#------------------------------------------------------------------------------
resource "azurerm_virtual_network" "vnet" {
  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  location            = azurerm_resource_group.tfe_prereqs.location
  name                = "${var.friendly_name_prefix}-${var.vnet_name}"
  address_space       = var.vnet_cidr

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-${var.vnet_name}" },
    var.common_tags
  )
}

#------------------------------------------------------------------------------
# Subnets
#------------------------------------------------------------------------------
resource "azurerm_subnet" "bastion" {
  resource_group_name  = azurerm_resource_group.tfe_prereqs.name
  name                 = "${var.friendly_name_prefix}-tfe-bastion-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

resource "azurerm_subnet" "lb" {
  resource_group_name  = azurerm_resource_group.tfe_prereqs.name
  name                 = "${var.friendly_name_prefix}-tfe-lb-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.lb_subnet_cidr]
}

resource "azurerm_subnet" "vm" {
  resource_group_name  = azurerm_resource_group.tfe_prereqs.name
  name                 = "${var.friendly_name_prefix}-tfe-vm-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.vm_subnet_cidr]

  service_endpoints = [
    "Microsoft.Sql",
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
}

resource "azurerm_subnet" "db" {
  resource_group_name  = azurerm_resource_group.tfe_prereqs.name
  name                 = "${var.friendly_name_prefix}-tfe-db-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.db_subnet_cidr]

  delegation {
    name = "flexibleServers"

    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

#------------------------------------------------------------------------------
# NAT Gateway
#------------------------------------------------------------------------------
resource "azurerm_public_ip" "nat" {
  count = var.create_nat_gateway == true ? 1 : 0

  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  location            = azurerm_resource_group.tfe_prereqs.location
  name                = "${var.friendly_name_prefix}-tfe-ng-ip"
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-tfe-ng-ip" },
    var.common_tags
  )
}

resource "azurerm_nat_gateway" "nat" {
  count = var.create_nat_gateway == true ? 1 : 0

  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  location            = azurerm_resource_group.tfe_prereqs.location
  name                = "${var.friendly_name_prefix}-tfe-ng"
  sku_name            = "Standard"
  zones               = ["1"]

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-tfe-ng" },
    var.common_tags
  )
}

resource "azurerm_nat_gateway_public_ip_association" "nat" {
  count = var.create_nat_gateway == true ? 1 : 0

  nat_gateway_id       = azurerm_nat_gateway.nat[0].id
  public_ip_address_id = azurerm_public_ip.nat[0].id
}

resource "azurerm_subnet_nat_gateway_association" "nat" {
  count = var.create_nat_gateway == true ? 1 : 0

  nat_gateway_id = azurerm_nat_gateway.nat[0].id
  subnet_id      = azurerm_subnet.vm.id
}