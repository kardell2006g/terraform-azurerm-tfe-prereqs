#------------------------------------------------------------------------------
# Bastion Subnet NSG
#------------------------------------------------------------------------------
resource "azurerm_network_security_group" "bastion" {
  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  location            = azurerm_resource_group.tfe_prereqs.location
  name                = "${var.friendly_name_prefix}-bastion-nsg"

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-bastion-nsg" },
    var.common_tags
  )
}

resource "azurerm_network_security_rule" "bastion_ingress_ssh" {
  resource_group_name         = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name = azurerm_network_security_group.bastion.name
  name                        = "${var.friendly_name_prefix}-bastion-ingress-ssh"
  description                 = "Allow list for SSH inbound to bastion."
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.bastion_ingress_cidr_allow
  destination_address_prefix  = var.bastion_subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

#------------------------------------------------------------------------------
# LB Subnet NSG
#------------------------------------------------------------------------------
resource "azurerm_network_security_group" "lb" {
  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  location            = azurerm_resource_group.tfe_prereqs.location
  name                = "${var.friendly_name_prefix}-tfe-lb-nsg"

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-tfe-lb-nsg" },
    var.common_tags
  )
}

resource "azurerm_network_security_rule" "lb_ingress_443" {
  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.lb.name
  name                         = "${var.friendly_name_prefix}-tfe-lb-ingress-443"
  description                  = "Allow list for 443 (HTTPS) traffic inbound to TFE app."
  priority                     = 1001
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "443"
  source_address_prefixes      = var.tfe_lb_ingress_cidr_allow_443 == null ? var.tfe_vm_ingress_cidr_allow_443 : var.tfe_lb_ingress_cidr_allow_443
  destination_address_prefixes = [var.lb_subnet_cidr]
}

resource "azurerm_network_security_rule" "lb_ingress_8800" {
  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.lb.name
  name                         = "${var.friendly_name_prefix}-tfe-lb-ingress-8800"
  description                  = "Allow list for 8800 (HTTPS) traffic inbound to TFE Admin Console."
  priority                     = 1002
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "8800"
  source_address_prefixes      = var.tfe_lb_ingress_cidr_allow_8800 == null ? var.tfe_vm_ingress_cidr_allow_8800 : var.tfe_lb_ingress_cidr_allow_8800
  destination_address_prefixes = [var.lb_subnet_cidr]
}

resource "azurerm_network_security_rule" "lb_ingress_443_ngw" {
  count = var.create_nat_gateway == true && var.create_ngw_nsg_rule == true ? 1 : 0

  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.lb.name
  name                         = "${var.friendly_name_prefix}-tfe-lb-ingress-443-ngw"
  description                  = "Allow 443 traffic inbound to TFE LB subnet from NAT Gateway Public IP."
  priority                     = 1003
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "443"
  source_address_prefix        = azurerm_public_ip.nat[0].ip_address
  destination_address_prefixes = [var.lb_subnet_cidr]
}

resource "azurerm_network_security_rule" "lb_ingress_9090" {
  count = var.create_monitoring_nsg_rules == true ? 1 : 0

  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.lb.name
  name                         = "${var.friendly_name_prefix}-tfe-lb-ingress-9090"
  description                  = "Allow list for 9090 (HTTP) traffic inbound to TFE metrics port."
  priority                     = 1004
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "9090"
  source_address_prefixes      = var.tfe_lb_ingress_cidr_allow_monitoring == null ? var.tfe_vm_ingress_cidr_allow_monitoring : var.tfe_lb_ingress_cidr_allow_monitoring
  destination_address_prefixes = [var.lb_subnet_cidr]
}

resource "azurerm_network_security_rule" "lb_ingress_9091" {
  count = var.create_monitoring_nsg_rules == true ? 1 : 0

  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.lb.name
  name                         = "${var.friendly_name_prefix}-tfe-lb-ingress-9091"
  description                  = "Allow list for 9091 (HTTPS) traffic inbound to TFE metrics port."
  priority                     = 1005
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "9091"
  source_address_prefixes      = var.tfe_lb_ingress_cidr_allow_monitoring == null ? var.tfe_vm_ingress_cidr_allow_monitoring : var.tfe_lb_ingress_cidr_allow_monitoring
  destination_address_prefixes = [var.lb_subnet_cidr]
}

resource "azurerm_subnet_network_security_group_association" "lb" {
  subnet_id                 = azurerm_subnet.lb.id
  network_security_group_id = azurerm_network_security_group.lb.id
}

#------------------------------------------------------------------------------
# VM Subnet NSG
#------------------------------------------------------------------------------
resource "azurerm_network_security_group" "vm" {
  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  location            = azurerm_resource_group.tfe_prereqs.location
  name                = "${var.friendly_name_prefix}-tfe-vm-nsg"

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-tfe-vm-nsg" },
    var.common_tags
  )
}

resource "azurerm_network_security_rule" "vm_ingress_443" {
  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.vm.name
  name                         = "${var.friendly_name_prefix}-tfe-vm-ingress-443"
  description                  = "Allow list for 443 (HTTPS) traffic inbound to TFE app."
  priority                     = 1001
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "443"
  source_address_prefixes      = var.tfe_vm_ingress_cidr_allow_443
  destination_address_prefixes = [var.vm_subnet_cidr]
}

resource "azurerm_network_security_rule" "vm_ingress_8800" {
  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.vm.name
  name                         = "${var.friendly_name_prefix}-tfe-vm-ingress-8800"
  description                  = "Allow list for 8800 (HTTPS) traffic inbound to TFE Admin Console."
  priority                     = 1002
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "8800"
  source_address_prefixes      = var.tfe_vm_ingress_cidr_allow_8800
  destination_address_prefixes = [var.vm_subnet_cidr]
}

resource "azurerm_network_security_rule" "vm_ingress_443_ngw" {
  count = var.create_nat_gateway == true && var.create_ngw_nsg_rule == true ? 1 : 0

  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.lb.name
  name                         = "${var.friendly_name_prefix}-tfe-vm-ingress-443-ngw"
  description                  = "Allow 443 traffic inbound to TFE VM subnet from NAT Gateway Public IP."
  priority                     = 1003
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "443"
  source_address_prefix        = azurerm_public_ip.nat[0].ip_address
  destination_address_prefixes = [var.vm_subnet_cidr]
}

resource "azurerm_network_security_rule" "vm_ingress_9090" {
  count = var.create_monitoring_nsg_rules == true ? 1 : 0

  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.vm.name
  name                         = "${var.friendly_name_prefix}-tfe-vm-ingress-9090"
  description                  = "Allow list for 9090 (HTTP) traffic inbound to TFE metrics port."
  priority                     = 1004
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "9090"
  source_address_prefixes      = var.tfe_vm_ingress_cidr_allow_monitoring
  destination_address_prefixes = [var.vm_subnet_cidr]
}

resource "azurerm_network_security_rule" "vm_ingress_9091" {
  count = var.create_monitoring_nsg_rules == true ? 1 : 0

  resource_group_name          = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name  = azurerm_network_security_group.vm.name
  name                         = "${var.friendly_name_prefix}-tfe-vm-ingress-9091"
  description                  = "Allow list for 9091 (HTTPS) traffic inbound to TFE metrics port."
  priority                     = 1005
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "*"
  destination_port_range       = "9091"
  source_address_prefixes      = var.tfe_vm_ingress_cidr_allow_monitoring
  destination_address_prefixes = [var.vm_subnet_cidr]
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  subnet_id                 = azurerm_subnet.vm.id
  network_security_group_id = azurerm_network_security_group.vm.id
}

#------------------------------------------------------------------------------
# DB Subnet NSG
#------------------------------------------------------------------------------
resource "azurerm_network_security_group" "db" {
  resource_group_name = azurerm_resource_group.tfe_prereqs.name
  location            = azurerm_resource_group.tfe_prereqs.location
  name                = "${var.friendly_name_prefix}-tfe-db-nsg"

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-tfe-db-nsg" },
    var.common_tags
  )
}

resource "azurerm_network_security_rule" "postgres_ingress" {
  resource_group_name         = azurerm_resource_group.tfe_prereqs.name
  network_security_group_name = azurerm_network_security_group.db.name
  name                        = "${var.friendly_name_prefix}-postgres-ingress"
  description                 = "Allow PostgreSQL traffic ingress from VM subnet."
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefixes     = [var.vm_subnet_cidr]
  destination_address_prefix  = var.db_subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "db" {
  subnet_id                 = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db.id
}