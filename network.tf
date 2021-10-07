resource "azurerm_virtual_network" "redmine_vn" {
  name                = "redmineVM"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.redmine_rg.location
  resource_group_name = azurerm_resource_group.redmine_rg.name
  tags = {
    application = "redmine"
  }
}

resource "azurerm_subnet" "redmine_public_subnet" {
  name                 = "publicSubnet"
  resource_group_name  = azurerm_resource_group.redmine_rg.name
  virtual_network_name = azurerm_virtual_network.redmine_vn.name
  address_prefixes     = ["10.0.10.0/24"]
}

resource "azurerm_public_ip" "public_ip1" {
  name                = "pip1"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.redmine_rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags = {
    application = "redmine"
  }
}

resource "azurerm_public_ip" "public_ip2" {
  name                = "pip2"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.redmine_rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags = {
    application = "redmine"
  }
}

