terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.15.1"
    }
  }
}

provider "azurerm" {
  environment = "public"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azurerm" {
  alias       = "secondary"
  environment = "public"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

#---------------------------------------------------------------------------
# Primary Region
#---------------------------------------------------------------------------
module "tfe-prereqs-primary" {
  source = "../.."

  # --- Common --- #
  friendly_name_prefix = var.friendly_name_prefix_primary
  location             = var.primary_location
  common_tags          = var.common_tags_primary
  resource_group_name  = var.resource_group_name_primary

  # --- Networking --- #
  vnet_name                      = var.vnet_name_primary
  vnet_cidr                      = var.vnet_cidr_primary
  bastion_subnet_cidr            = var.bastion_subnet_cidr_primary
  lb_subnet_cidr                 = var.lb_subnet_cidr_primary
  vm_subnet_cidr                 = var.vm_subnet_cidr_primary
  db_subnet_cidr                 = var.db_subnet_cidr_primary
  public_dns_zone_name           = var.public_dns_zone_name
  create_nat_gateway             = var.create_nat_gateway
  bastion_ingress_cidr_allow     = var.bastion_ingress_cidr_allow
  tfe_lb_ingress_cidr_allow_443  = var.tfe_lb_ingress_cidr_allow_443
  tfe_lb_ingress_cidr_allow_8800 = var.tfe_lb_ingress_cidr_allow_8800
  tfe_vm_ingress_cidr_allow_443  = var.tfe_vm_ingress_cidr_allow_443
  tfe_vm_ingress_cidr_allow_8800 = var.tfe_vm_ingress_cidr_allow_8800

  # --- Bastion --- #
  bastion_ssh_public_key = var.bastion_ssh_public_key

  # --- "Bootstrap" Key Vault --- #
  kv_ingress_cidr_allow = var.kv_ingress_cidr_allow
  kv_console_password   = var.kv_console_password
  kv_enc_password       = var.kv_enc_password
  kv_tfe_cert_b64       = var.kv_tfe_cert_b64
  kv_tfe_privkey_b64    = var.kv_tfe_privkey_b64
  kv_ca_bundle          = var.kv_ca_bundle

  # --- "Bootstrap" Blob Storage --- #
  sa_ingress_cidr_allow = var.sa_ingress_cidr_allow

  # --- Log Forwarding --- #
  deploy_logging_bucket             = var.deploy_logging_bucket
  deploy_log_analytics_workspace    = var.deploy_log_analytics_workspace
  log_analytics_workspace_retention = var.log_analytics_workspace_retention

  # --- Monitoring --- #
  create_monitoring_nsg_rules          = var.create_monitoring_nsg_rules
  tfe_lb_ingress_cidr_allow_monitoring = var.tfe_lb_ingress_cidr_allow_monitoring
  tfe_vm_ingress_cidr_allow_monitoring = var.tfe_vm_ingress_cidr_allow_monitoring
}

#---------------------------------------------------------------------------
# Secondary Region
#---------------------------------------------------------------------------
module "tfe-prereqs-secondary" {
  source = "../.."

  depends_on = [
    module.tfe-prereqs-primary
  ]

  providers = {
    azurerm = azurerm.secondary
  }

  # --- Common --- #
  friendly_name_prefix = var.friendly_name_prefix_secondary
  location             = var.secondary_location
  common_tags          = var.common_tags_secondary
  resource_group_name  = var.resource_group_name_secondary

  # --- Networking --- #
  vnet_name                      = var.vnet_name_secondary
  vnet_cidr                      = var.vnet_cidr_secondary
  bastion_subnet_cidr            = var.bastion_subnet_cidr_secondary
  lb_subnet_cidr                 = var.lb_subnet_cidr_secondary
  vm_subnet_cidr                 = var.vm_subnet_cidr_secondary
  db_subnet_cidr                 = var.db_subnet_cidr_secondary
  create_nat_gateway             = var.create_nat_gateway
  bastion_ingress_cidr_allow     = var.bastion_ingress_cidr_allow
  tfe_lb_ingress_cidr_allow_443  = var.tfe_lb_ingress_cidr_allow_443
  tfe_lb_ingress_cidr_allow_8800 = var.tfe_lb_ingress_cidr_allow_8800
  tfe_vm_ingress_cidr_allow_443  = var.tfe_vm_ingress_cidr_allow_443
  tfe_vm_ingress_cidr_allow_8800 = var.tfe_vm_ingress_cidr_allow_8800

  # --- Bastion --- #
  bastion_ssh_public_key = var.bastion_ssh_public_key

  # --- "Bootstrap" Key Vault --- #
  kv_ingress_cidr_allow = var.kv_ingress_cidr_allow
  kv_console_password   = var.kv_console_password
  kv_enc_password       = var.kv_enc_password
  kv_tfe_cert_b64       = var.kv_tfe_cert_b64
  kv_tfe_privkey_b64    = var.kv_tfe_privkey_b64
  kv_ca_bundle          = var.kv_ca_bundle

  # --- "Bootstrap" Blob Storage --- #
  sa_ingress_cidr_allow = var.sa_ingress_cidr_allow

  # --- Log Forwarding --- #
  deploy_logging_bucket             = var.deploy_logging_bucket
  deploy_log_analytics_workspace    = var.deploy_log_analytics_workspace
  log_analytics_workspace_retention = var.log_analytics_workspace_retention

  # --- Monitoring --- #
  create_monitoring_nsg_rules          = var.create_monitoring_nsg_rules
  tfe_lb_ingress_cidr_allow_monitoring = var.tfe_lb_ingress_cidr_allow_monitoring
  tfe_vm_ingress_cidr_allow_monitoring = var.tfe_vm_ingress_cidr_allow_monitoring
}
