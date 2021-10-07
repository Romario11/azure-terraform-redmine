output "external_ip_server" {
  value = azurerm_linux_virtual_machine.redmine_server.public_ip_address
}

output "external_ip_db" {
  value = azurerm_linux_virtual_machine.redmine_db.public_ip_address
}