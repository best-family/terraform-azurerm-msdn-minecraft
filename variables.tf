variable "SUBSCRIPTION_ID" {
  type        = string
  description = "AzureRM Subscription ID"
}

variable "CLIENT_ID" {
  type        = string
  description = "AzureRM Client ID"
}

variable "CLIENT_SECRET" {
  type        = string
  description = "AzureRM Client Secret"
}

variable "TENANT_ID" {
  type        = string
  description = "AzureRM Tenant ID"
}

variable "PREFIX" {
  type        = string
  description = "The prefix to use with resource naming."
}

variable "LOCATION" {
  type        = string
  description = "The Azure location to build in."
  default     = "australiaeast"
}

variable "ENVIRONMENT" {
  type        = string
  description = "The SDLC landscape. Used to determine if the zone data is inserted into the Dev Subscription or the Prod Subscription. (Must be \"dev\" or \"prod\".)"
}

variable "TAGS" {
  type        = map(string)
  description = "The tags to use on all resources."
  default = { environment = "dev",
    terraform   = "true",
    cicdManaged = "tfc",
    createdBy   = "abest@diaxion.com"
  }
}

variable "MINECRAFT_LINUX_HOSTNAME" {
  type        = string
  description = "The hostname to assign to the OS in the Linux jumphost."
}

variable "source_address_prefixes_ipv4_allowlist" {
  type        = list(string)
  description = "List of IPv4 address prefixes to allow connections from. "
  default     = ["159.196.149.239"]
}

variable "source_address_prefixes_ipv6_allowlist" {
  type        = list(string)
  description = "List of IPv6 address prefixes to allow connections from. "
  default     = ["2403:5800:7800:b400::/56"]
}

variable "jumphost_admin_name" {
  description = "The username to use on the jumphosts."
  type        = string
  default     = "festivus"
}

variable "jumphost_os_disk_size" {
  type        = string
  description = "The size in Gb for the OS disk of the primary seed virtual machine"
  default     = "100"
}

variable "jumphost_linux_vm_size" {
  description = "The Azure VM size to use for Linux Jumphosts."
  type        = string
  default     = "Standard_A2_v2"
}

variable "jumphost_linux_storage_image" {
  type        = map(string)
  description = "A list of the data to define the os version image to build from"

  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
