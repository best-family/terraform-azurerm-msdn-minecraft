locals {
  #ssh-cli             = "ssh -v ${var.jumphost_admin_name}@${azurerm_dns_cname_record.jump01.fqdn}"
  #web-url             = "https://${azurerm_dns_cname_record.jump01.fqdn}"
  parent-zone         = var.ENVIRONMENT == "prod" ? "bestfamily.id.au" : "dev.bestfamily.id.au"
  cloud00-parent-zone = var.ENVIRONMENT == "prod" ? "cloud00.bestfamily.id.au" : "dev.cloud00.bestfamily.id.au"
}
