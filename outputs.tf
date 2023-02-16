#-------------------------------------------------------------------------
# Common
#-------------------------------------------------------------------------
output "resource_group_name" {
  description = "Name of the Resource Group."
  value       = azurerm_resource_group.tfe_prereqs.name
}

output "location" {
  description = "The Region resources exist in."
  value       = azurerm_resource_group.tfe_prereqs.location
}

#-------------------------------------------------------------------------
# VNet
#-------------------------------------------------------------------------
output "vnet_name" {
  description = "Name of the VNET."
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "ID of the VNET."
  value       = azurerm_virtual_network.vnet.id
}

output "bastion_subnet_cidr" {
  description = "Bastion subnet CIDR."
  value       = azurerm_subnet.bastion.address_prefixes
}

output "bastion_subnet_id" {
  description = "Bastion subnet ID."
  value       = azurerm_subnet.bastion.id
}

output "lb_subnet_cidr" {
  description = "Load Balancer subnet CIDR."
  value       = azurerm_subnet.lb.address_prefixes
}

output "lb_subnet_id" {
  description = "Load Balancer subnet ID."
  value       = azurerm_subnet.lb.id
}

output "vm_subnet_cidr" {
  description = "VM subnet CIDR."
  value       = azurerm_subnet.vm.address_prefixes
}

output "vm_subnet_id" {
  description = "VM subnet ID."
  value       = azurerm_subnet.vm.id
}

output "db_subnet_cidr" {
  description = "Database subnet CIDR."
  value       = azurerm_subnet.db.address_prefixes
}

output "db_subnet_id" {
  description = "Database subnet ID."
  value       = azurerm_subnet.db.id
}

output "nat_gateway_public_ip" {
  description = "The public IP of the NAT gateway."
  value       = try(azurerm_public_ip.nat[0].ip_address, null)
}

#-------------------------------------------------------------------------
# DNS
#-------------------------------------------------------------------------
output "public_dns_zone_id" {
  description = "The public DNS zone ID."
  value       = try(azurerm_dns_zone.public[0].id, null)
}

output "private_dns_zone_id" {
  description = "The private DNS zone ID."
  value       = try(azurerm_private_dns_zone.private[0].id, null)
}

#-------------------------------------------------------------------------
# Bastion
#-------------------------------------------------------------------------
output "bastion_ssh_username" {
  description = "The bastion server SSH username."
  value       = var.bastion_ssh_username
}

output "bastion_fqdn" {
  description = "The fully qualified domain name of the bastion server."
  value       = azurerm_public_ip.bastion.fqdn
}

output "bastion_public_ip" {
  description = "The public IP of the bastion server."
  value       = azurerm_linux_virtual_machine.bastion.public_ip_address
}

#-------------------------------------------------------------------------
# Key Vault
#-------------------------------------------------------------------------
output "keyvault_id" {
  description = "The Key Vault ID."
  value       = azurerm_key_vault.tfe_bootstrap_kv.id
}

output "console_password_kv_id" {
  description = "The ID of the TFE console secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.console_password[0].id, null)
}

output "console_password_kv_name" {
  description = "The name of the TFE console secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.console_password[0].name, null)
}

output "enc_password_kv_id" {
  description = "The ID of the TFE encryption secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.enc_password[0].id, null)
}

output "enc_password_kv_name" {
  description = "The name of the TFE encryption secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.enc_password[0].name, null)
}

output "tfe_cert_kv_id" {
  description = "The ID of the TFE TLS certificate secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.tfe_cert[0].id, null)
}

output "tfe_cert_kv_name" {
  description = "The name of the TFE TLS certificate secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.tfe_cert[0].name, null)
}

output "tfe_privkey_kv_id" {
  description = "The ID of the TFE TLS certificate private key secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.tfe_privkey[0].id, null)
}

output "tfe_privkey_kv_name" {
  description = "The name of the TFE TLS certificate private key secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.tfe_privkey[0].name, null)
}

output "ca_bundle_kv_id" {
  description = "The ID of the full-chain TLS certificate secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.ca_bundle[0].id, null)
}

output "ca_bundle_kv_name" {
  description = "The name of the full-chain TLS certificate secret in Azure Key Vault."
  value       = try(azurerm_key_vault_secret.ca_bundle[0].name, null)
}

#-------------------------------------------------------------------------
# Blob Storage
#-------------------------------------------------------------------------
output "bootstrap_sa_id" {
  description = "The ID of the bootstrap Storage Account."
  value       = azurerm_storage_account.bootstrap.id
}

output "bootstrap_sa_name" {
  description = "The name of the bootstrap Storage Account."
  value       = azurerm_storage_account.bootstrap.name
}

output "bootstrap_sa_primary_location" {
  description = "The primary location of the bootstrap Storage Account."
  value       = azurerm_storage_account.bootstrap.primary_location
}

output "bootstrap_sa_secondary_location" {
  description = "The secondary location of the bootstrap Storage Account."
  value       = azurerm_storage_account.bootstrap.secondary_location
}

output "bootstrap_sa_primary_blob_endpoint" {
  description = "The primary Storage Account blob endpoint."
  value       = azurerm_storage_account.bootstrap.primary_blob_endpoint
}

output "bootstrap_sa_secondary_blob_endpoint" {
  description = "The secondary Storage Account blob endpoint."
  value       = azurerm_storage_account.bootstrap.secondary_blob_endpoint
}

#-------------------------------------------------------------------------
# Logging
#-------------------------------------------------------------------------
output "logging_sa_id" {
  description = "The ID of the logging Storage Account."
  value       = try(azurerm_storage_account.logging[0].id, null)
}

output "logging_sa_name" {
  description = "The name of the logging Storage Account."
  value       = try(azurerm_storage_account.logging[0].name, null)
}

output "logging_storage_container_name" {
  description = "The name of the logging storage container within the logging Storage Account."
  value       = try(azurerm_storage_container.logging[0].name, null)
}

output "azurerm_log_analytics_workspace" {
  description = "The name of the Log Analytics Workspace."
  value       = try(azurerm_log_analytics_workspace.logging[0].name, null)
}
