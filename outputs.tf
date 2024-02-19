output "dns_name" {
  value       = try(azurerm_bastion_host.main[0].dns_name, null)
  description = "Specifies the name of the bastion host"
}

output "id" {
  value       = try(azurerm_bastion_host.main[0].id, null)
  description = "Specifies the resource id of the bastion host"
}
