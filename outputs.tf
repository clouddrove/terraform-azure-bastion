output "dns_name" {
  value       = azurerm_bastion_host.main[0].dns_name
  description = "Specifies the name of the bastion host"
}

output "id" {
  value       = azurerm_bastion_host.main[0].id
  description = "Specifies the resource id of the bastion host"
}
