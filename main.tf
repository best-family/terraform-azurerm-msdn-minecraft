terraform {
  required_version = ">= 0.15"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "BestFamily"

    workspaces {
      prefix = "terraform-azurerm-msdn-minecraft-"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.SUBSCRIPTION_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  tenant_id       = var.TENANT_ID
}

// https://www.terraform.io/docs/providers/azurerm/r/resource_group.html
// resource group for the jumphost
resource "azurerm_resource_group" "terraform-azurerm-msdn-minecraft" {
  location = var.LOCATION
  name     = "${var.PREFIX}-${var.ENVIRONMENT}-rg"

  tags = var.TAGS
}
