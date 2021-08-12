// cname resource definition for minecraft.dev.cloud00
// https://www.terraform.io/docs/providers/azurerm/r/dns_cname_record.html
resource "azurerm_dns_cname_record" "minecraft" {
  name                = var.MINECRAFT_LINUX_HOSTNAME
  zone_name           = local.cloud00-parent-zone
  resource_group_name = data.terraform_remote_state.terraform-azurerm-msdn-dns.outputs.dns-familyDNSZones-name
  ttl                 = 300
  record              = azurerm_public_ip.terraform-azurerm-msdn-minecraft-v4-pip0.fqdn
}

// https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record
resource "azurerm_dns_srv_record" "minecraft" {
  name                = var.MINECRAFT_LINUX_HOSTNAME
  zone_name           = local.cloud00-parent-zone
  resource_group_name = data.terraform_remote_state.terraform-azurerm-msdn-dns.outputs.dns-familyDNSZones-name
  ttl                 = 300

  record {
    priority = 1
    weight   = 5
    port     = 25565
    target   = azurerm_public_ip.terraform-azurerm-msdn-minecraft-v4-pip0.fqdn
  }
}
