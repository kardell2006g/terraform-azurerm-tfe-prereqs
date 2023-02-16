# Single Region
In this scenario, resources are provisioned in a single region.
<p>&nbsp;</p>


## Usage
See [main.tf](./main.tf) and [example terraform.tfvars](./terraform.tfvars.example).
<p>&nbsp;</p>


## Resources Provisioned
* VNET
  * Bastion Subnet
  * Load Balancer Subnet
  * DB Subnet
  * NAT Gateways (for each Public Subnet)
  * Network Security Groups
* Azure DNS Zone
* Bastion host
* "bootstrap" Storage Account
* Log Analytics Storage Account
* Log Analytics Workspace
* Azure Key Vault
  * TFE Secrets

## Requirements

| Name | Version |
|------|---------|
| azurerm | ~> 3.15.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| tfe-prereqs | ../.. | n/a |

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
| azurerm\_log\_analytics\_workspace | n/a |
| bastion\_fqdn | n/a |
| bastion\_public\_ip | n/a |
| bastion\_subnet\_id | n/a |
| bootstrap\_sa\_id | n/a |
| bootstrap\_sa\_name | n/a |
| bootstrap\_sa\_primary\_blob\_endpoint | n/a |
| bootstrap\_sa\_primary\_location | n/a |
| bootstrap\_sa\_secondary\_blob\_endpoint | n/a |
| bootstrap\_sa\_secondary\_location | n/a |
| ca\_bundle\_kv\_id | n/a |
| console\_password\_kv\_id | n/a |
| console\_password\_kv\_name | n/a |
| db\_subnet\_id | n/a |
| enc\_password\_kv\_id | n/a |
| enc\_password\_kv\_name | n/a |
| keyvault\_id | n/a |
| lb\_subnet\_id | n/a |
| logging\_sa\_id | n/a |
| logging\_sa\_name | n/a |
| logging\_storage\_container\_name | n/a |
| nat\_gateway\_public\_ip | n/a |
| tfe\_cert\_kv\_id | n/a |
| tfe\_privkey\_kv\_id | n/a |
| vm\_subnet\_id | n/a |
| vnet\_id | n/a |