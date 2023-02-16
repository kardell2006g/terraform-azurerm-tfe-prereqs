output "vnet_id_primary" {
  value = module.tfe-prereqs-primary.vnet_id
}

output "vnet_id_secondary" {
  value = module.tfe-prereqs-secondary.vnet_id
}

output "bastion_subnet_id_primary" {
  value = module.tfe-prereqs-primary.bastion_subnet_id
}

output "bastion_subnet_id_secondary" {
  value = module.tfe-prereqs-secondary.bastion_subnet_id
}

output "lb_subnet_id_primary" {
  value = module.tfe-prereqs-primary.lb_subnet_id
}

output "lb_subnet_id_secondary" {
  value = module.tfe-prereqs-secondary.lb_subnet_id
}

output "vm_subnet_id_primary" {
  value = module.tfe-prereqs-primary.vm_subnet_id
}

output "vm_subnet_id_secondary" {
  value = module.tfe-prereqs-secondary.vm_subnet_id
}

output "db_subnet_id_primary" {
  value = module.tfe-prereqs-primary.db_subnet_id
}

output "db_subnet_id_secondary" {
  value = module.tfe-prereqs-secondary.db_subnet_id
}

output "bastion_fqdn_primary" {
  value = module.tfe-prereqs-primary.bastion_fqdn
}

output "bastion_fqdn_secondary" {
  value = module.tfe-prereqs-secondary.bastion_fqdn
}

output "bastion_public_ip_primary" {
  value = module.tfe-prereqs-primary.bastion_public_ip
}

output "bastion_public_ip_secondary" {
  value = module.tfe-prereqs-secondary.bastion_public_ip
}

output "nat_gateway_public_ip_primary" {
  value = module.tfe-prereqs-primary.nat_gateway_public_ip
}

output "nat_gateway_public_ip_secondary" {
  value = module.tfe-prereqs-secondary.nat_gateway_public_ip
}

output "keyvault_id_primary" {
  value = module.tfe-prereqs-primary.keyvault_id
}

output "keyvault_id_secondary" {
  value = module.tfe-prereqs-secondary.keyvault_id
}

output "console_password_kv_id_primary" {
  value = module.tfe-prereqs-primary.console_password_kv_id
}

output "console_password_kv_id_secondary" {
  value = module.tfe-prereqs-secondary.console_password_kv_id
}

output "console_password_kv_name_primary" {
  value = module.tfe-prereqs-primary.console_password_kv_name
}

output "console_password_kv_name_secondary" {
  value = module.tfe-prereqs-secondary.console_password_kv_name
}

output "enc_password_kv_id_primary" {
  value = module.tfe-prereqs-primary.enc_password_kv_id
}

output "enc_password_kv_id_secondary" {
  value = module.tfe-prereqs-secondary.enc_password_kv_id
}

output "enc_password_kv_name_primary" {
  value = module.tfe-prereqs-primary.enc_password_kv_name
}

output "enc_password_kv_name_secondary" {
  value = module.tfe-prereqs-secondary.enc_password_kv_name
}

output "tfe_cert_kv_id_primary" {
  value = module.tfe-prereqs-primary.tfe_cert_kv_id
}

output "tfe_cert_kv_id_secondary" {
  value = module.tfe-prereqs-secondary.tfe_cert_kv_id
}

output "tfe_privkey_kv_id_primary" {
  value = module.tfe-prereqs-primary.tfe_privkey_kv_id
}

output "tfe_privkey_kv_id_secondary" {
  value = module.tfe-prereqs-secondary.tfe_privkey_kv_id
}

output "ca_bundle_kv_id_primary" {
  value = module.tfe-prereqs-primary.ca_bundle_kv_id
}

output "ca_bundle_kv_id_secondary" {
  value = module.tfe-prereqs-secondary.ca_bundle_kv_id
}

output "bootstrap_sa_id_primary" {
  value = module.tfe-prereqs-primary.bootstrap_sa_id
}

output "bootstrap_sa_id_secondary" {
  value = module.tfe-prereqs-secondary.bootstrap_sa_id
}

output "bootstrap_sa_name_primary" {
  value = module.tfe-prereqs-primary.bootstrap_sa_name
}

output "bootstrap_sa_name_secondary" {
  value = module.tfe-prereqs-secondary.bootstrap_sa_name
}

output "bootstrap_sa_primary_location" {
  value = module.tfe-prereqs-primary.bootstrap_sa_primary_location
}

output "bootstrap_sa_secondary_location" {
  value = module.tfe-prereqs-secondary.bootstrap_sa_secondary_location
}

output "bootstrap_sa_primary_blob_endpoint" {
  value = module.tfe-prereqs-primary.bootstrap_sa_primary_blob_endpoint
}

output "bootstrap_sa_secondary_blob_endpoint" {
  value = module.tfe-prereqs-secondary.bootstrap_sa_secondary_blob_endpoint
}

output "logging_sa_id_primary" {
  value = module.tfe-prereqs-primary.logging_sa_id
}

output "logging_sa_id_secondary" {
  value = module.tfe-prereqs-secondary.logging_sa_id
}

output "logging_sa_name_primary" {
  value = module.tfe-prereqs-primary.logging_sa_name
}

output "logging_sa_name_secondary" {
  value = module.tfe-prereqs-secondary.logging_sa_name
}

output "logging_storage_container_name_primary" {
  value = module.tfe-prereqs-primary.logging_storage_container_name
}

output "logging_storage_container_name_secondary" {
  value = module.tfe-prereqs-secondary.logging_storage_container_name
}

output "azurerm_log_analytics_workspace_primary" {
  value = module.tfe-prereqs-primary.azurerm_log_analytics_workspace
}

output "azurerm_log_analytics_workspace_secondary" {
  value = module.tfe-prereqs-secondary.azurerm_log_analytics_workspace
}
