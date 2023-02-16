
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
  features {}
}

module "tfe-prereqs" {
  source = "../.."

  # --- Common --- #
  friendly_name_prefix = var.friendly_name_prefix
  location             = var.location
  common_tags          = var.common_tags

  # --- Networking --- #
  vnet_name                      = var.vnet_name
  vnet_cidr                      = var.vnet_cidr
  bastion_subnet_cidr            = var.bastion_subnet_cidr
  lb_subnet_cidr                 = var.lb_subnet_cidr
  vm_subnet_cidr                 = var.vm_subnet_cidr
  db_subnet_cidr                 = var.db_subnet_cidr
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
