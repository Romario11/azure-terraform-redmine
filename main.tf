terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  subscription_id = file(var.subscription_id)
  client_id       = file(var.id_client)
  client_secret   = file(var.secret_azure)
  tenant_id       = file(var.tenant_id)
  features {}
}

resource "azurerm_resource_group" "redmine_rg" {
  name     = "redmineResourceGroup"
  location = "West Europe"
  tags = {
    application = "redmine"
  }
}
