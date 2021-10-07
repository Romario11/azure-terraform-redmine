resource "azurerm_linux_virtual_machine" "redmine_db" {
  name                = "redmineDB"
  resource_group_name = azurerm_resource_group.redmine_rg.name
  location            = azurerm_resource_group.redmine_rg.location
  size                = "Standard_B1s"
  admin_username      = var.user_name

  custom_data    = base64encode(templatefile(var.db_up_script, {
    DB_PASSWORD =file(var.db_password),
    DB_USER = var.db_user_name,
    DB_NAME = var.db_name }))

  network_interface_ids = [
    azurerm_network_interface.redmine_ni_db.id,
  ]

  admin_ssh_key {
    username   = var.user_name
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    application = "redmine"
  }

}




resource "azurerm_network_interface" "redmine_ni_db" {
  name                = "redmine-NI-db"
  location            = azurerm_resource_group.redmine_rg.location
  resource_group_name = azurerm_resource_group.redmine_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.redmine_public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip2.id
  }
  tags = {
    application = "redmine"
  }
}