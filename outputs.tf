output "virtual_hub_connections_id" {
  description = "Map of id values across all virtual_hub_connections, keyed the same as var.virtual_hub_connections"
  value       = { for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : k => v.id }
}
output "virtual_hub_connections_internet_security_enabled" {
  description = "Map of internet_security_enabled values across all virtual_hub_connections, keyed the same as var.virtual_hub_connections"
  value       = { for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : k => v.internet_security_enabled }
}
output "virtual_hub_connections_name" {
  description = "Map of name values across all virtual_hub_connections, keyed the same as var.virtual_hub_connections"
  value       = { for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : k => v.name }
}
output "virtual_hub_connections_remote_virtual_network_id" {
  description = "Map of remote_virtual_network_id values across all virtual_hub_connections, keyed the same as var.virtual_hub_connections"
  value       = { for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : k => v.remote_virtual_network_id }
}
output "virtual_hub_connections_routing" {
  description = "Map of routing values across all virtual_hub_connections, keyed the same as var.virtual_hub_connections"
  value       = { for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : k => v.routing }
}
output "virtual_hub_connections_virtual_hub_id" {
  description = "Map of virtual_hub_id values across all virtual_hub_connections, keyed the same as var.virtual_hub_connections"
  value       = { for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : k => v.virtual_hub_id }
}

