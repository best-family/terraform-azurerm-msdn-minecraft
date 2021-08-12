# https://www.terraform.io/docs/providers/azurerm/r/network_security_group.html
resource "azurerm_network_security_group" "terraform-azurerm-msdn-minecraft-nsg" {
  name                = "${var.PREFIX}-${var.ENVIRONMENT}-nsg"
  resource_group_name = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  location            = var.LOCATION
  tags                = var.TAGS
}

# Network Security Group Subnet Associations
resource "azurerm_subnet_network_security_group_association" "terraform-azurerm-msdn-minecraft" {
  subnet_id                 = data.terraform_remote_state.msdn-networking.outputs.subnet_endpoint_id
  network_security_group_id = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.id
}

# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_icmp" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-icmp"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow ICMP access."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "ICMP"
  source_address_prefix       = "*" #tfsec:ignore:AZU001
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  priority                    = 100
}

# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_ipv4_ssh" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-ipv4-ssh"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow ssh access for debugging."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.source_address_prefixes_ipv4_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
  priority                    = 101
}

# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_ipv6_ssh" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-ipv6-ssh"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow ssh access for debugging."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.source_address_prefixes_ipv6_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
  priority                    = 102
}

# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_https" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-web"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow web access."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*" #tfsec:ignore:AZU001
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80", "443"]
  priority                    = 103
}

# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_ipv4_vault" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-ipv4-vault"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow vault access."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.source_address_prefixes_ipv4_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "8200"
  priority                    = 104
}

# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_ipv6_vault" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-ipv6-vault"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow vault access."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.source_address_prefixes_ipv6_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "8200"
  priority                    = 105
}

//25565
# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_ipv4_minecraft" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-ipv4-minecraft"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow minecraft access."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.source_address_prefixes_ipv4_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "25565"
  priority                    = 104
}

# https://www.terraform.io/docs/providers/azurerm/r/network_security_rule.html
resource "azurerm_network_security_rule" "allow_ipv6_minecraft" {
  name                        = "${var.PREFIX}-${var.ENVIRONMENT}-ipv6-minecraft"
  resource_group_name         = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  network_security_group_name = azurerm_network_security_group.terraform-azurerm-msdn-minecraft-nsg.name
  description                 = "Allow minecraft access."
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefixes     = var.source_address_prefixes_ipv6_allowlist
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "25565"
  priority                    = 104
}
