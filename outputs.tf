output "dns_name" {
  value       = join("", azurerm_bastion_host.main.*.dns_name)
  description = "Specifies the name of the bastion host"
}

output "id" {
  value       = join("", azurerm_bastion_host.main.*.id)
  description = "Specifies the resource id of the bastion host"
}
