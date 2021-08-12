locals {
  ssh-cli             = "ssh -v ${var.minecraft_admin_name}@${azurerm_dns_srv_record.minecraft.fqdn}"
  parent-zone         = var.ENVIRONMENT == "prod" ? "bestfamily.id.au" : "dev.bestfamily.id.au"
  cloud00-parent-zone = var.ENVIRONMENT == "prod" ? "cloud00.bestfamily.id.au" : "dev.cloud00.bestfamily.id.au"
}
