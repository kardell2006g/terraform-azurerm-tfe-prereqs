# terraform-azurerm-tfe-prereqs
Terraform module to deploy TFE prerequisites on Azure relative to this [TFE on Azure](https://github.com/hashicorp-services/terraform-azurerm-tfe) module _accelerator_. This module may not be all-encompassing for all users' environments/requirements, however the core resources to support the aforementioned TFE on Azure module _accelerator_ are included.
<p>&nbsp;</p>


## Requirements
- Azure Subscription w/ `contributor` role or equivalent permissions
- Terraform `>= 1.2.5` installed on client/workstation you are running Terraform on
<p>&nbsp;</p>


## Usage
See the [example scenarios](./tests/) within the **tests** directory. The scenarios contain a ready-made Terraform configuration for single or multi-region deployments. Aside from the prereqs, all that is required to deploy is populating your own variable values in the `terraform.tfvars.example` template that is provided in the given scenarios subdirectory (and subsequently removing the `.example` file extension before Terraform applying).

### NSG Rules
How to specify values for the NSG input variables will depend on the load balancing scheme (`internal` or `external`) that you will choose when you eventually deploy TFE.

#### Internal-facing Load Balancer
If your TFE instance will not be exposed externally and rather will be kept internal-facing, then the load balancer will be assigned private IP address from within the `lb_subnet_cidr` range. Therefore, you can specify values for the `tfe_lb_ingress_cidr_allow_*` input variables with CIDR ranges that are allowed to talk inbound to TFE, and for the `tfe_vm_ingress_cidr_allow_*` values specify the load balancer subnet CIDR range.

```hcl
# --- Load Balancer Subnet NSG Rules --- #
tfe_lb_ingress_cidr_allow_443  = ["1.1.1.1/24", "5.6.7.8/32"] # TFE client access subnets, VCS subnet, etc.
tfe_lb_ingress_cidr_allow_8800 = ["1.1.1.1/24"]               # TFE admin client access subnets

# --- VM Subnet NSG Rules --- #
tfe_vm_ingress_cidr_allow_443  = ["10.0.1.0/24"] # CIDR range of LB subnet
tfe_vm_ingress_cidr_allow_8800 = ["10.0.1.0/24"] # CIDR range of LB subnet
```

#### External-facing Load Balancer
If your TFE instance will be external-facing (if your VCS is a hosted SaaS such as github.com, for example), then there will be no load balancer subnet needed as the load balancer will be assigned a Public IP resource. In this case, you would omit the `tfe_lb_ingress_cidr_allow_*` input variables (they default to `null`) and only specify values for the `tfe_vm_ingress_cidr_allow_*` input variables like so:

```hcl
tfe_vm_ingress_cidr_allow_443  = ["1.1.1.1/24", "5.6.7.8/32"] # TFE client access subnets, VCS subnet, etc.
tfe_vm_ingress_cidr_allow_8800 = ["1.1.1.1/24"]               # TFE admin client access subnets
```
<p>&nbsp;</p>


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.2.5 |
| azurerm | >= 3.15.1 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.15.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_key_vault.tfe_bootstrap_kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.kv_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.ca_bundle](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.console_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.enc_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.tfe_cert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.tfe_privkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_linux_virtual_machine.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_log_analytics_workspace.logging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway) | resource |
| [azurerm_nat_gateway_public_ip_association.nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway_public_ip_association) | resource |
| [azurerm_network_interface.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.bastion_ingress_ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.lb_ingress_443](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.lb_ingress_443_ngw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.lb_ingress_8800](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.lb_ingress_9090](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.lb_ingress_9091](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.postgres_ingress](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.vm_ingress_443](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.vm_ingress_443_ngw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.vm_ingress_8800](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.vm_ingress_9090](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.vm_ingress_9091](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_private_dns_zone.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_public_ip.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.tfe_prereqs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.bootstrap](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account.logging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.bootstrap](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_container.logging](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_subnet.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_nat_gateway_association.nat](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_nat_gateway_association) | resource |
| [azurerm_subnet_network_security_group_association.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.lb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion\_ingress\_cidr\_allow | List of CIDRs allowed inbound to bastion via SSH (port 22) on bastion subnet. | `list(string)` | `[]` | no |
| bastion\_ssh\_public\_key | SSH public key for bastion host. | `string` | `""` | no |
| bastion\_ssh\_username | SSH username for bastion host. | `string` | `"ubuntu"` | no |
| bastion\_subnet\_cidr | CIDR block for bastion subnet. | `string` | `"10.0.255.0/24"` | no |
| common\_tags | Map of common tags for taggable Azure resources. | `map(string)` | `{}` | no |
| create\_monitoring\_nsg\_rules | Boolean to create NSG Rules to allow traffic inbound to TFE Metrics Endpoint. | `bool` | `false` | no |
| create\_nat\_gateway | Boolean to create a NAT Gateway. Useful when Azure Load Balancer is internal but VM(s) require outbound Internet access. | `bool` | `false` | no |
| create\_ngw\_nsg\_rule | Boolean to create NSG Rule to allow traffic inbound to TFE over port 443 from NAT Gateway IP. | `bool` | `false` | no |
| db\_subnet\_cidr | CIDR block for TFE database subnet. | `string` | `"10.0.3.0/24"` | no |
| deploy\_log\_analytics\_workspace | Boolean to deploy an Azure Log Analytics Workspace to be used for TFE Logs | `bool` | `false` | no |
| deploy\_logging\_bucket | Boolean to deploy an Azure Storage account to be used for TFE Logs | `bool` | `false` | no |
| friendly\_name\_prefix | Friendly name prefix for unique Azure resource naming across deployments. | `string` | n/a | yes |
| kv\_ca\_bundle | Azure Key Vault secret value for custom CA bundle named `ca-bundle`. Must be stored as a string with new lines replaced by `<br>`. | `string` | `null` | no |
| kv\_console\_password | Azure Key Vault secret value for TFE install secret named `console-password`. | `string` | `null` | no |
| kv\_enc\_password | Azure Key Vault secret value for TFE install secret named `enc-password`. | `string` | `null` | no |
| kv\_ingress\_cidr\_allow | List of CIDRs allowed to interact with Azure Key Vault. | `list(string)` | `[]` | no |
| kv\_tfe\_cert\_b64 | Azure Key Vault secret value for base64-encoded TFE server certificate secret named `tfe-cert`. Certificate must be in PEM format before base64 encoding. | `string` | `null` | no |
| kv\_tfe\_privkey\_b64 | Azure Key Vault secret value for base64-encoded TFE server certificate private key secret named `tfe-privkey`. Private key must be in PEM format before base64 encoding. | `string` | `null` | no |
| lb\_subnet\_cidr | CIDR block for TFE load balancer subnet. | `string` | `"10.0.1.0/24"` | no |
| location | Azure region to deploy into. | `string` | `"East US 2"` | no |
| log\_analytics\_workspace\_retention | Days to retain logs | `number` | `30` | no |
| network\_default\_action | Sets the default action for network rules/ACLs for Blob Storage and Key Vault; either `Allow` or `Deny`. | `string` | `"Deny"` | no |
| private\_dns\_zone\_name | Name of private Azure DNS Zone to create. One will not be created if left as `null`. | `string` | `null` | no |
| public\_dns\_zone\_name | Name of public Azure DNS Zone to create. One will not be created if left as `null`. | `string` | `null` | no |
| redis\_subnet\_cidr | CIDR block for TFE redis subnet. | `string` | `"10.0.4.0/24"` | no |
| resource\_group\_name | Name of Resource Group to create. | `string` | `"tfe-prereqs-rg"` | no |
| sa\_ingress\_cidr\_allow | List of CIDRs allowed to interact with Azure Blob Storage Account. | `list(string)` | `[]` | no |
| tfe\_lb\_ingress\_cidr\_allow\_443 | List of CIDRs allowed inbound to TFE application on port 443 on load balancer subnet. | `list(string)` | `null` | no |
| tfe\_lb\_ingress\_cidr\_allow\_8800 | List of CIDRs allowed inbound to TFE Admin Console on port 8800 on load balancer subnet. | `list(string)` | `null` | no |
| tfe\_lb\_ingress\_cidr\_allow\_monitoring | List of CIDRs allowed inbound to TFE Metrics Endpoint on ports 9090 and 9091 on load balancer subnet. | `list(string)` | `null` | no |
| tfe\_vm\_ingress\_cidr\_allow\_443 | List of CIDRs allowed inbound to TFE application on port 443 on VM subnet. | `list(string)` | `[]` | no |
| tfe\_vm\_ingress\_cidr\_allow\_8800 | List of CIDRs allowed inbound to TFE Admin Console on port 8800 on VM subnet. | `list(string)` | `[]` | no |
| tfe\_vm\_ingress\_cidr\_allow\_monitoring | List of CIDRs allowed inbound to TFE Metrics Endpoint on ports 9090 and 9091 on VM subnet. | `list(string)` | `[]` | no |
| vm\_subnet\_cidr | CIDR block for TFE VM subnet. | `string` | `"10.0.2.0/24"` | no |
| vnet\_cidr | CIDR block address space for VNet. | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| vnet\_name | Name of VNET to create. | `string` | `"tfe-vnet"` | no |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_log\_analytics\_workspace | The name of the Log Analytics Workspace. |
| bastion\_fqdn | The fully qualified domain name of the bastion server. |
| bastion\_public\_ip | The public IP of the bastion server. |
| bastion\_ssh\_username | The bastion server SSH username. |
| bastion\_subnet\_cidr | Bastion subnet CIDR. |
| bastion\_subnet\_id | Bastion subnet ID. |
| bootstrap\_sa\_id | The ID of the bootstrap Storage Account. |
| bootstrap\_sa\_name | The name of the bootstrap Storage Account. |
| bootstrap\_sa\_primary\_blob\_endpoint | The primary Storage Account blob endpoint. |
| bootstrap\_sa\_primary\_location | The primary location of the bootstrap Storage Account. |
| bootstrap\_sa\_secondary\_blob\_endpoint | The secondary Storage Account blob endpoint. |
| bootstrap\_sa\_secondary\_location | The secondary location of the bootstrap Storage Account. |
| ca\_bundle\_kv\_id | The ID of the full-chain TLS certificate secret in Azure Key Vault. |
| ca\_bundle\_kv\_name | The name of the full-chain TLS certificate secret in Azure Key Vault. |
| console\_password\_kv\_id | The ID of the TFE console secret in Azure Key Vault. |
| console\_password\_kv\_name | The name of the TFE console secret in Azure Key Vault. |
| db\_subnet\_cidr | Database subnet CIDR. |
| db\_subnet\_id | Database subnet ID. |
| enc\_password\_kv\_id | The ID of the TFE encryption secret in Azure Key Vault. |
| enc\_password\_kv\_name | The name of the TFE encryption secret in Azure Key Vault. |
| keyvault\_id | The Key Vault ID. |
| lb\_subnet\_cidr | Load Balancer subnet CIDR. |
| lb\_subnet\_id | Load Balancer subnet ID. |
| location | The Region resources exist in. |
| logging\_sa\_id | The ID of the logging Storage Account. |
| logging\_sa\_name | The name of the logging Storage Account. |
| logging\_storage\_container\_name | The name of the logging storage container within the logging Storage Account. |
| nat\_gateway\_public\_ip | The public IP of the NAT gateway. |
| private\_dns\_zone\_id | The private DNS zone ID. |
| public\_dns\_zone\_id | The public DNS zone ID. |
| resource\_group\_name | Name of the Resource Group. |
| tfe\_cert\_kv\_id | The ID of the TFE TLS certificate secret in Azure Key Vault. |
| tfe\_cert\_kv\_name | The name of the TFE TLS certificate secret in Azure Key Vault. |
| tfe\_privkey\_kv\_id | The ID of the TFE TLS certificate private key secret in Azure Key Vault. |
| tfe\_privkey\_kv\_name | The name of the TFE TLS certificate private key secret in Azure Key Vault. |
| vm\_subnet\_cidr | VM subnet CIDR. |
| vm\_subnet\_id | VM subnet ID. |
| vnet\_id | ID of the VNET. |
| vnet\_name | Name of the VNET. |