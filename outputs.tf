output "virtual_hub_connections" {
  description = "All virtual_hub_connection resources"
  value       = azurerm_virtual_hub_connection.virtual_hub_connections
}
output "virtual_hub_connections_internet_security_enabled" {
  description = "List of internet_security_enabled values across all virtual_hub_connections"
  value       = [for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : v.internet_security_enabled]
}
output "virtual_hub_connections_name" {
  description = "List of name values across all virtual_hub_connections"
  value       = [for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : v.name]
}
output "virtual_hub_connections_remote_virtual_network_id" {
  description = "List of remote_virtual_network_id values across all virtual_hub_connections"
  value       = [for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : v.remote_virtual_network_id]
}
output "virtual_hub_connections_routing" {
  description = "List of routing values across all virtual_hub_connections"
  value       = [for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : v.routing]
}
output "virtual_hub_connections_virtual_hub_id" {
  description = "List of virtual_hub_id values across all virtual_hub_connections"
  value       = [for k, v in azurerm_virtual_hub_connection.virtual_hub_connections : v.virtual_hub_id]
}

