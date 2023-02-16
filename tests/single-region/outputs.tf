output "vnet_id" {
  value = module.tfe-prereqs.vnet_id
}

output "bastion_subnet_id" {
  value = module.tfe-prereqs.bastion_subnet_id
}

output "lb_subnet_id" {
  value = module.tfe-prereqs.lb_subnet_id
}

output "vm_subnet_id" {
  value = module.tfe-prereqs.vm_subnet_id
}

output "db_subnet_id" {
  value = module.tfe-prereqs.db_subnet_id
}

output "bastion_fqdn" {
  value = module.tfe-prereqs.bastion_fqdn
}

output "bastion_public_ip" {
  value = module.tfe-prereqs.bastion_public_ip
}

output "nat_gateway_public_ip" {
  value = module.tfe-prereqs.nat_gateway_public_ip
}

output "keyvault_id" {
  value = module.tfe-prereqs.keyvault_id
}

output "console_password_kv_id" {
  value = module.tfe-prereqs.console_password_kv_id
}

output "console_password_kv_name" {
  value = module.tfe-prereqs.console_password_kv_name
}

output "enc_password_kv_id" {
  value = module.tfe-prereqs.enc_password_kv_id
}

output "enc_password_kv_name" {
  value = module.tfe-prereqs.enc_password_kv_name
}

output "tfe_cert_kv_id" {
  value = module.tfe-prereqs.tfe_cert_kv_id
}

output "tfe_privkey_kv_id" {
  value = module.tfe-prereqs.tfe_privkey_kv_id
}

output "ca_bundle_kv_id" {
  value = module.tfe-prereqs.ca_bundle_kv_id
}

output "bootstrap_sa_id" {
  value = module.tfe-prereqs.bootstrap_sa_id
}

output "bootstrap_sa_name" {
  value = module.tfe-prereqs.bootstrap_sa_name
}

output "bootstrap_sa_primary_location" {
  value = module.tfe-prereqs.bootstrap_sa_primary_location
}

output "bootstrap_sa_secondary_location" {
  value = module.tfe-prereqs.bootstrap_sa_secondary_location
}

output "bootstrap_sa_primary_blob_endpoint" {
  value = module.tfe-prereqs.bootstrap_sa_primary_blob_endpoint
}

output "bootstrap_sa_secondary_blob_endpoint" {
  value = module.tfe-prereqs.bootstrap_sa_secondary_blob_endpoint
}

output "logging_sa_id" {
  value = module.tfe-prereqs.logging_sa_id
}

output "logging_sa_name" {
  value = module.tfe-prereqs.logging_sa_name
}

output "logging_storage_container_name" {
  value = module.tfe-prereqs.logging_storage_container_name
}

output "azurerm_log_analytics_workspace" {
  value = module.tfe-prereqs.azurerm_log_analytics_workspace
}
