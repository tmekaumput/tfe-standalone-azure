# Terraform Enterprise Azure - Vanilla

## About this repository

The repository utilises the Terraform Enterprise Azure module to create Terraform Enterprise environment with External Services and Private Endpoints in vNet. It also returns the IACT token for subsequent process.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.79.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.79.1 |
| <a name="provider_http"></a> [http](#provider\_http) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tfe"></a> [tfe](#module\_tfe) | github.com/tmekaumput/terraform-azurerm-terraform-enterprise | v1.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.tfe_license](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [null_resource.wait_for_tfe](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [azurerm_key_vault_certificate.load_balancer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_certificate) | data source |
| [azurerm_key_vault_secret.vm_ca](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.vm_certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.vm_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [http_http.iact](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.icanhazip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_blob_public_access"></a> [allow\_blob\_public\_access](#input\_allow\_blob\_public\_access) | 'Allow public access to the Storage account | `bool` | `false` | no |
| <a name="input_create_bastion"></a> [create\_bastion](#input\_create\_bastion) | If true, will create Azure Bastion PaaS and required resources https://azure.microsoft.com/en-us/services/azure-bastion/ | `bool` | `true` | no |
| <a name="input_database_flexible_server"></a> [database\_flexible\_server](#input\_database\_flexible\_server) | Type of Postgres database resource, `azurerm_postgresql_flexible_server` or `azurerm_postgresql_server` | `bool` | `true` | no |
| <a name="input_database_machine_type"></a> [database\_machine\_type](#input\_database\_machine\_type) | Postgres sku short name: tier + family + cores | `string` | `"GP_Standard_D4s_v3"` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | Postgres version | `number` | `12` | no |
| <a name="input_dedicated_subnets"></a> [dedicated\_subnets](#input\_dedicated\_subnets) | (Optional) Share subnet with application or having dedicated subnets for the storage and database | `bool` | `false` | no |
| <a name="input_default_action_ip_rules"></a> [default\_action\_ip\_rules](#input\_default\_action\_ip\_rules) | The IP rules for the Storage account default action | `list(string)` | `[]` | no |
| <a name="input_default_action_subnet_ids"></a> [default\_action\_subnet\_ids](#input\_default\_action\_subnet\_ids) | The Subnet Ids for the Storage account default action | `list(string)` | `[]` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain to create Terraform Enterprise subdomain within | `string` | n/a | yes |
| <a name="input_friendly_name_prefix"></a> [friendly\_name\_prefix](#input\_friendly\_name\_prefix) | (Required) Name prefix used for resources | `string` | n/a | yes |
| <a name="input_iact_subnet_list"></a> [iact\_subnet\_list](#input\_iact\_subnet\_list) | An array of string contains the list of subnets that allows | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The identity of the Key Vault which contains secrets and certificates. | `string` | n/a | yes |
| <a name="input_license_file"></a> [license\_file](#input\_license\_file) | The local path to the Terraform Enterprise license to be provided by CI. | `string` | n/a | yes |
| <a name="input_load_balancer_key_vault_certificate_name"></a> [load\_balancer\_key\_vault\_certificate\_name](#input\_load\_balancer\_key\_vault\_certificate\_name) | The secret name of the certificate in Key Vault to upload into the load balancer | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location name e.g. East US | `string` | `"East US"` | no |
| <a name="input_network_rules_default_action"></a> [network\_rules\_default\_action](#input\_network\_rules\_default\_action) | Storage account default access rule, which can be 'Allow' or 'Deny' | `string` | n/a | yes |
| <a name="input_private_link_enforced"></a> [private\_link\_enforced](#input\_private\_link\_enforced) | (Optional) Enforce private link policies | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Azure resource group name | `string` | n/a | yes |
| <a name="input_resource_group_name_dns"></a> [resource\_group\_name\_dns](#input\_resource\_group\_name\_dns) | Name of resource group which contains desired DNS zone | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of string contains tag attributes | `map(string)` | `{}` | no |
| <a name="input_tfe_subdomain"></a> [tfe\_subdomain](#input\_tfe\_subdomain) | Subdomain for TFE | `string` | n/a | yes |
| <a name="input_vm_ca_key_vault_secret_name"></a> [vm\_ca\_key\_vault\_secret\_name](#input\_vm\_ca\_key\_vault\_secret\_name) | The secret name of the certificate private key in Key Vault to upload into TFE installation | `string` | n/a | yes |
| <a name="input_vm_certificate_key_vault_secret_name"></a> [vm\_certificate\_key\_vault\_secret\_name](#input\_vm\_certificate\_key\_vault\_secret\_name) | The secret name of the certificate in Key Vault to upload into TFE installation | `string` | n/a | yes |
| <a name="input_vm_node_count"></a> [vm\_node\_count](#input\_vm\_node\_count) | The number of instances to create for TFE environment | `number` | `2` | no |
| <a name="input_vm_private_key_key_vault_secret_name"></a> [vm\_private\_key\_key\_vault\_secret\_name](#input\_vm\_private\_key\_key\_vault\_secret\_name) | The secret name of the certificate private key in Key Vault to upload into TFE installation | `string` | n/a | yes |
| <a name="input_vm_sku"></a> [vm\_sku](#input\_vm\_sku) | Azure virtual machine sku | `string` | `"Standard_D4_v3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iact"></a> [iact](#output\_iact) | n/a |
| <a name="output_instance_private_key"></a> [instance\_private\_key](#output\_instance\_private\_key) | The SSH private key to the TFE instance(s) |
| <a name="output_instance_user_name"></a> [instance\_user\_name](#output\_instance\_user\_name) | The admin user on the TFE instance(s) |
| <a name="output_login_url"></a> [login\_url](#output\_login\_url) | Login URL to setup the TFE instance once it is initialized |
| <a name="output_tfe_application_url"></a> [tfe\_application\_url](#output\_tfe\_application\_url) | Terraform Enterprise Application URL |
| <a name="output_tfe_console_password"></a> [tfe\_console\_password](#output\_tfe\_console\_password) | The password for the TFE console |
| <a name="output_tfe_console_url"></a> [tfe\_console\_url](#output\_tfe\_console\_url) | Terraform Enterprise Console URL |
<!-- END_TF_DOCS -->