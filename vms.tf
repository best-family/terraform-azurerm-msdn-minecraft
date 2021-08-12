# https://www.terraform.io/docs/providers/azurerm/r/public_ip.html
resource "azurerm_public_ip" "terraform-azurerm-msdn-minecraft-jump01-v4-pip0" {
  allocation_method   = "Static"
  domain_name_label   = "${var.MINECRAFT_LINUX_HOSTNAME}-${var.ENVIRONMENT}"
  ip_version          = "IPv4"
  location            = var.LOCATION
  name                = "${var.PREFIX}-${var.ENVIRONMENT}-jump01-v4-pip0"
  resource_group_name = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  sku                 = "Standard"

  tags = var.TAGS
}

# https://www.terraform.io/docs/providers/azurerm/r/public_ip.html
resource "azurerm_public_ip" "terraform-azurerm-msdn-minecraft-jump01-v6-pip0" {
  allocation_method   = "Static"
  domain_name_label   = "${var.MINECRAFT_LINUX_HOSTNAME}-${var.ENVIRONMENT}"
  ip_version          = "IPv6"
  location            = var.LOCATION
  name                = "${var.PREFIX}-${var.ENVIRONMENT}-jump01-v6-pip0"
  resource_group_name = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  sku                 = "Standard"

  tags = var.TAGS
}

# https://www.terraform.io/docs/providers/azurerm/r/network_interface.html
resource "azurerm_network_interface" "terraform-azurerm-msdn-minecraft-jump01-nic0" {
  name                = "${var.PREFIX}-${var.ENVIRONMENT}-jump01-nic0"
  location            = var.LOCATION
  resource_group_name = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name

  tags = var.TAGS

  ip_configuration {
    name                          = "${var.PREFIX}-${var.ENVIRONMENT}-jump01-v4-ipconf0"
    subnet_id                     = data.terraform_remote_state.msdn-networking.outputs.subnet_endpoint_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.terraform-azurerm-msdn-minecraft-jump01-v4-pip0.id
    private_ip_address_version    = "IPv4"
  }
  ip_configuration {
    name                          = "${var.PREFIX}-${var.ENVIRONMENT}-jump01-v6-ipconf0"
    subnet_id                     = data.terraform_remote_state.msdn-networking.outputs.subnet_endpoint_id
    private_ip_address_allocation = "Dynamic"
    primary                       = false
    public_ip_address_id          = azurerm_public_ip.terraform-azurerm-msdn-minecraft-jump01-v6-pip0.id
    private_ip_address_version    = "IPv6"
  }
}

# https://www.terraform.io/docs/providers/azurerm/r/linux_virtual_machine.html
resource "azurerm_linux_virtual_machine" "terraform-azurerm-msdn-minecraft-jump01-vm0" {
  admin_username = var.minecraft_admin_name
  location       = var.LOCATION
  name           = "${var.PREFIX}-${var.ENVIRONMENT}-${var.MINECRAFT_LINUX_HOSTNAME}-vm"
  network_interface_ids = [
    azurerm_network_interface.terraform-azurerm-msdn-minecraft-jump01-nic0.id
  ]
  resource_group_name = azurerm_resource_group.terraform-azurerm-msdn-minecraft.name
  size                = var.minecraft_linux_vm_size
  computer_name       = var.MINECRAFT_LINUX_HOSTNAME
  //custom_data         = data.template_cloudinit_config.config.rendered

  identity {
    type = "SystemAssigned"
  }

  admin_ssh_key {
    public_key = file("./ssh/id_rsa_abest_barmix2.pub")
    username   = var.minecraft_admin_name
  }

  admin_ssh_key {
    public_key = file("./ssh/id_rsa_pi_raspberrypi.pub")
    username   = var.minecraft_admin_name
  }

  admin_ssh_key {
    public_key = file("./ssh/id_rsa_root_raspberrypi.pub")
    username   = var.minecraft_admin_name
  }

  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = var.minecraft_os_disk_size
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.minecraft_linux_storage_image["publisher"]
    offer     = var.minecraft_linux_storage_image["offer"]
    sku       = var.minecraft_linux_storage_image["sku"]
    version   = var.minecraft_linux_storage_image["version"]
  }

  tags = var.TAGS
}

# now we are going to do some MSI related items for our VM
# Using this page as a guide: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/managed_service_identity
# get the current Azure Subscription ID into a data resource.
data "azurerm_subscription" "current" {}

# define what role we want the MSI to have on the Subscription
data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "minecraft" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_linux_virtual_machine.terraform-azurerm-msdn-minecraft-jump01-vm0.identity[0].principal_id
  //  skip_service_principal_aad_check = true
  //  principal_id       = azurerm_virtual_machine.example.identity[0]["principal_id"]

  depends_on = [azurerm_linux_virtual_machine.terraform-azurerm-msdn-minecraft-jump01-vm0]
}

# The diagnostics settings on the msdnStorage SA are based on an example in https://github.com/terraform-providers/terraform-provider-azurerm/issues/12090
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories
data "azurerm_monitor_diagnostic_categories" "terraform-azurerm-msdn-minecraft-jump01-vm0" {
  resource_id = azurerm_linux_virtual_machine.terraform-azurerm-msdn-minecraft-jump01-vm0.id
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "jump01-vm0" {
  name                       = "${var.PREFIX}-${var.ENVIRONMENT}-jump01-vm0-diagnostics"
  target_resource_id         = azurerm_linux_virtual_machine.terraform-azurerm-msdn-minecraft-jump01-vm0.id
  log_analytics_workspace_id = data.terraform_remote_state.terraform-azurerm-msdn-storage.outputs.logAnalyticsWorkspace.resource_id

  dynamic "log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.terraform-azurerm-msdn-minecraft-jump01-vm0.logs)
    content {
      category = log.key
      enabled  = true

      retention_policy {
        enabled = false
      }
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      enabled = false
    }
  }
}
