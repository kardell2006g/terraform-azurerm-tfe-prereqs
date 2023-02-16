#-------------------------------------------------------------------------
# Common
#-------------------------------------------------------------------------
variable "resource_group_name" {
  type        = string
  description = "Name of Resource Group to create."
  default     = "tfe-prereqs-rg"
}

variable "location" {
  type        = string
  description = "Azure region to deploy into."
  default     = "East US 2"
}

variable "friendly_name_prefix" {
  type        = string
  description = "Friendly name prefix for unique Azure resource naming across deployments."

  validation {
    condition     = can(regex("^[[:alnum:]]+$", var.friendly_name_prefix)) && length(var.friendly_name_prefix) < 13
    error_message = "Must only contain alphanumeric characters and be less than 13 characters."
  }
}

variable "common_tags" {
  type        = map(string)
  description = "Map of common tags for taggable Azure resources."
  default     = {}
}

#-------------------------------------------------------------------------
# VNet
#-------------------------------------------------------------------------
variable "vnet_name" {
  type        = string
  description = "Name of VNET to create."
  default     = "tfe-vnet"
}

variable "vnet_cidr" {
  type        = list(string)
  description = "CIDR block address space for VNet."
  default     = ["10.0.0.0/16"]
}

variable "bastion_subnet_cidr" {
  type        = string
  description = "CIDR block for bastion subnet."
  default     = "10.0.255.0/24"
}

variable "lb_subnet_cidr" {
  type        = string
  description = "CIDR block for TFE load balancer subnet."
  default     = "10.0.1.0/24"
}

variable "vm_subnet_cidr" {
  type        = string
  description = "CIDR block for TFE VM subnet."
  default     = "10.0.2.0/24"
}

variable "db_subnet_cidr" {
  type        = string
  description = "CIDR block for TFE database subnet."
  default     = "10.0.3.0/24"
}

variable "redis_subnet_cidr" {
  type        = string
  description = "CIDR block for TFE redis subnet."
  default     = "10.0.4.0/24"
}

variable "create_nat_gateway" {
  type        = bool
  description = "Boolean to create a NAT Gateway. Useful when Azure Load Balancer is internal but VM(s) require outbound Internet access."
  default     = false
}

variable "network_default_action" {
  type        = string
  description = "Sets the default action for network rules/ACLs for Blob Storage and Key Vault; either `Allow` or `Deny`."
  default     = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.network_default_action)
    error_message = "Must be 'Allow' or 'Deny', yes it is case sensitive."
  }
}

#-------------------------------------------------------------------------
# NSG
#-------------------------------------------------------------------------
variable "bastion_ingress_cidr_allow" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to bastion via SSH (port 22) on bastion subnet."
  default     = []
}

variable "tfe_lb_ingress_cidr_allow_443" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to TFE application on port 443 on load balancer subnet."
  default     = null
}

variable "tfe_lb_ingress_cidr_allow_8800" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to TFE Admin Console on port 8800 on load balancer subnet."
  default     = null
}

variable "create_ngw_nsg_rule" {
  type        = bool
  description = "Boolean to create NSG Rule to allow traffic inbound to TFE over port 443 from NAT Gateway IP."
  default     = false
}

variable "create_monitoring_nsg_rules" {
  type        = bool
  description = "Boolean to create NSG Rules to allow traffic inbound to TFE Metrics Endpoint."
  default     = false
}

variable "tfe_lb_ingress_cidr_allow_monitoring" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to TFE Metrics Endpoint on ports 9090 and 9091 on load balancer subnet."
  default     = null
}

variable "tfe_vm_ingress_cidr_allow_443" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to TFE application on port 443 on VM subnet."
  default     = []
}

variable "tfe_vm_ingress_cidr_allow_8800" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to TFE Admin Console on port 8800 on VM subnet."
  default     = []
}

variable "tfe_vm_ingress_cidr_allow_monitoring" {
  type        = list(string)
  description = "List of CIDRs allowed inbound to TFE Metrics Endpoint on ports 9090 and 9091 on VM subnet."
  default     = []
}

#-------------------------------------------------------------------------
# DNS
#-------------------------------------------------------------------------
variable "public_dns_zone_name" {
  type        = string
  description = "Name of public Azure DNS Zone to create. One will not be created if left as `null`."
  default     = null
}

variable "private_dns_zone_name" {
  type        = string
  description = "Name of private Azure DNS Zone to create. One will not be created if left as `null`."
  default     = null
}

#-------------------------------------------------------------------------
# Bastion
#-------------------------------------------------------------------------
variable "bastion_ssh_username" {
  type        = string
  description = "SSH username for bastion host."
  default     = "ubuntu"
}

variable "bastion_ssh_public_key" {
  type        = string
  description = "SSH public key for bastion host."
  default     = ""
}

#-------------------------------------------------------------------------
# Key Vault
#-------------------------------------------------------------------------
variable "kv_ingress_cidr_allow" {
  type        = list(string)
  description = "List of CIDRs allowed to interact with Azure Key Vault."
  default     = []
}

variable "kv_console_password" {
  type        = string
  description = "Azure Key Vault secret value for TFE install secret named `console-password`."
  default     = null
}

variable "kv_enc_password" {
  type        = string
  description = "Azure Key Vault secret value for TFE install secret named `enc-password`."
  default     = null
}

variable "kv_tfe_cert_b64" {
  type        = string
  description = "Azure Key Vault secret value for base64-encoded TFE server certificate secret named `tfe-cert`. Certificate must be in PEM format before base64 encoding."
  default     = null
}

variable "kv_tfe_privkey_b64" {
  type        = string
  description = "Azure Key Vault secret value for base64-encoded TFE server certificate private key secret named `tfe-privkey`. Private key must be in PEM format before base64 encoding."
  default     = null
}

variable "kv_ca_bundle" {
  type        = string
  description = "Azure Key Vault secret value for custom CA bundle named `ca-bundle`. Must be stored as a string with new lines replaced by `\n`."
  default     = null
}

#-------------------------------------------------------------------------
# Storage Account
#-------------------------------------------------------------------------
variable "sa_ingress_cidr_allow" {
  type        = list(string)
  description = "List of CIDRs allowed to interact with Azure Blob Storage Account."
  default     = []
}

#-------------------------------------------------------------------------
# Log Forwarding
#-------------------------------------------------------------------------
variable "deploy_logging_bucket" {
  type        = bool
  description = "Boolean to deploy an Azure Storage account to be used for TFE Logs"
  default     = false
}

variable "deploy_log_analytics_workspace" {
  type        = bool
  description = "Boolean to deploy an Azure Log Analytics Workspace to be used for TFE Logs"
  default     = false
}

variable "log_analytics_workspace_retention" {
  type        = number
  description = "Days to retain logs"
  default     = 30
}