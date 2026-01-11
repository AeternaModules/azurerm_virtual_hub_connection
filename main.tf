resource "azurerm_virtual_hub_connection" "virtual_hub_connections" {
  for_each = var.virtual_hub_connections

  name                      = each.value.name
  remote_virtual_network_id = each.value.remote_virtual_network_id
  virtual_hub_id            = each.value.virtual_hub_id
  internet_security_enabled = each.value.internet_security_enabled

  dynamic "routing" {
    for_each = each.value.routing != null ? [each.value.routing] : []
    content {
      associated_route_table_id = routing.value.associated_route_table_id
      inbound_route_map_id      = routing.value.inbound_route_map_id
      outbound_route_map_id     = routing.value.outbound_route_map_id
      dynamic "propagated_route_table" {
        for_each = routing.value.propagated_route_table != null ? [routing.value.propagated_route_table] : []
        content {
          labels          = propagated_route_table.value.labels
          route_table_ids = propagated_route_table.value.route_table_ids
        }
      }
      static_vnet_local_route_override_criteria   = routing.value.static_vnet_local_route_override_criteria
      static_vnet_propagate_static_routes_enabled = routing.value.static_vnet_propagate_static_routes_enabled
      dynamic "static_vnet_route" {
        for_each = routing.value.static_vnet_route != null ? [routing.value.static_vnet_route] : []
        content {
          address_prefixes    = static_vnet_route.value.address_prefixes
          name                = static_vnet_route.value.name
          next_hop_ip_address = static_vnet_route.value.next_hop_ip_address
        }
      }
    }
  }
}

