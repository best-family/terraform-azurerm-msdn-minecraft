# output "userdata" {
#   value = "\n${data.template_file.cloud_config.rendered}"
# }

output "minecraft-dev" {
  description = "Information about the dev jumphost."
  value = {
    v4_primary_public_ip = azurerm_public_ip.terraform-azurerm-msdn-minecraft-v4-pip0.ip_address
    v6_primary_public_ip = azurerm_public_ip.terraform-azurerm-msdn-minecraft-v6-pip0.ip_address
    ssh_cli              = local.ssh-cli
  }
  depends_on = [azurerm_linux_virtual_machine.terraform-azurerm-msdn-minecraft-vm0]
}
