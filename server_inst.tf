resource "azurerm_linux_virtual_machine" "redmine_server" {
  name                = "redmineSERVER"
  resource_group_name = azurerm_resource_group.redmine_rg.name
  location            = azurerm_resource_group.redmine_rg.location
  size                = "Standard_B1s"
  admin_username      = var.user_name

  custom_data = base64encode(templatefile(var.redmine_up_script, { USER_NAME = var.user_name }))

  network_interface_ids = [
    azurerm_network_interface.redmine_ni_server.id
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
  provisioner "file" {
    source      = "${path.module}/config/database.yml"
    destination = "/home/${var.user_name}/database.yml"
    connection {
      type        = "ssh"
      user        = var.user_name
      host        = self.public_ip_address
      private_key = file(var.ssh_private_key)
    }
  }
  depends_on = [local_file.db_config_redmine]
  tags = {
    application = "redmine"
  }
}

resource "local_file" "db_config_redmine" {
  content = templatefile("${path.module}/config/database.yml.template", {
    DB_HOST     = azurerm_linux_virtual_machine.redmine_db.public_ip_address
    DB_USER     = var.db_user_name,
    DB_PASSWORD = file(var.db_password),
    DB_NAME     = var.db_name,
    DB_ADAPTER  = var.db_adapter
  })
  filename = "${path.module}/config/database.yml"
}

resource "azurerm_network_interface" "redmine_ni_server" {
  name                = "redmine-NI-server"
  location            = azurerm_resource_group.redmine_rg.location
  resource_group_name = azurerm_resource_group.redmine_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.redmine_public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip1.id
  }
  tags = {
    application = "redmine"
  }
}