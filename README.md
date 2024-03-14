# terraform-azurerm-msdn-minecraft

The family Minecraft server

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.71.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_cname_record.minecraft](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_srv_record.minecraft](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_linux_virtual_machine.terraform-azurerm-msdn-minecraft-vm0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_monitor_diagnostic_setting.minecraft-vm0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_network_interface.terraform-azurerm-msdn-minecraft-nic0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.allow_icmp](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_ipv4_minecraft](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_ipv4_ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_ipv6_minecraft](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.allow_ipv6_ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.terraform-azurerm-msdn-minecraft-v4-pip0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.terraform-azurerm-msdn-minecraft-v6-pip0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.terraform-azurerm-msdn-minecraft](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.minecraft](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_subnet_network_security_group_association.terraform-azurerm-msdn-minecraft](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_monitor_diagnostic_categories.terraform-azurerm-msdn-minecraft-vm0](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |
| [azurerm_role_definition.contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/role_definition) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [terraform_remote_state.msdn-networking](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.terraform-azurerm-msdn-dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.terraform-azurerm-msdn-storage](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CLIENT_ID"></a> [CLIENT\_ID](#input\_CLIENT\_ID) | AzureRM Client ID | `string` | n/a | yes |
| <a name="input_CLIENT_SECRET"></a> [CLIENT\_SECRET](#input\_CLIENT\_SECRET) | AzureRM Client Secret | `string` | n/a | yes |
| <a name="input_ENVIRONMENT"></a> [ENVIRONMENT](#input\_ENVIRONMENT) | The SDLC landscape. Used to determine if the zone data is inserted into the Dev Subscription or the Prod Subscription. (Must be "dev" or "prod".) | `string` | n/a | yes |
| <a name="input_LOCATION"></a> [LOCATION](#input\_LOCATION) | The Azure location to build in. | `string` | `"australiaeast"` | no |
| <a name="input_MINECRAFT_LINUX_HOSTNAME"></a> [MINECRAFT\_LINUX\_HOSTNAME](#input\_MINECRAFT\_LINUX\_HOSTNAME) | The hostname to assign to the OS in the Linux Minecraft server. | `string` | n/a | yes |
| <a name="input_PREFIX"></a> [PREFIX](#input\_PREFIX) | The prefix to use with resource naming. | `string` | n/a | yes |
| <a name="input_SUBSCRIPTION_ID"></a> [SUBSCRIPTION\_ID](#input\_SUBSCRIPTION\_ID) | AzureRM Subscription ID | `string` | n/a | yes |
| <a name="input_TAGS"></a> [TAGS](#input\_TAGS) | The tags to use on all resources. | `map(string)` | <pre>{<br>  "cicdManaged": "tfc",<br>  "createdBy": "andrew.best@arq.group",<br>  "environment": "dev",<br>  "terraform": "true"<br>}</pre> | no |
| <a name="input_TENANT_ID"></a> [TENANT\_ID](#input\_TENANT\_ID) | AzureRM Tenant ID | `string` | n/a | yes |
| <a name="input_minecraft_admin_name"></a> [minecraft\_admin\_name](#input\_minecraft\_admin\_name) | The username to use on the Minecraft server. | `string` | `"festivus"` | no |
| <a name="input_minecraft_linux_storage_image"></a> [minecraft\_linux\_storage\_image](#input\_minecraft\_linux\_storage\_image) | A list of the data to define the os version image to build from | `map(string)` | <pre>{<br>  "offer": "0001-com-ubuntu-server-focal",<br>  "publisher": "Canonical",<br>  "sku": "20_04-lts",<br>  "version": "latest"<br>}</pre> | no |
| <a name="input_minecraft_linux_vm_size"></a> [minecraft\_linux\_vm\_size](#input\_minecraft\_linux\_vm\_size) | The Azure VM size to use for Linux minecrafts. | `string` | `"Standard_D2_v2"` | no |
| <a name="input_minecraft_os_disk_size"></a> [minecraft\_os\_disk\_size](#input\_minecraft\_os\_disk\_size) | The size in Gb for the OS disk of the primary seed virtual machine | `string` | `"100"` | no |
| <a name="input_source_address_prefixes_ipv4_allowlist"></a> [source\_address\_prefixes\_ipv4\_allowlist](#input\_source\_address\_prefixes\_ipv4\_allowlist) | List of IPv4 address prefixes to allow connections from. | `list(string)` | <pre>[<br>  "159.196.149.239"<br>]</pre> | no |
| <a name="input_source_address_prefixes_ipv6_allowlist"></a> [source\_address\_prefixes\_ipv6\_allowlist](#input\_source\_address\_prefixes\_ipv6\_allowlist) | List of IPv6 address prefixes to allow connections from. | `list(string)` | <pre>[<br>  "2403:5800:7800:b400::/56"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_minecraft-server"></a> [minecraft-server](#output\_minecraft-server) | Information about the minecraft server. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
