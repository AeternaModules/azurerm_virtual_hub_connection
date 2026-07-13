variable "virtual_hub_connections" {
  description = <<EOT
Map of virtual_hub_connections, attributes below
Required:
    - name
    - remote_virtual_network_id
    - virtual_hub_id
Optional:
    - internet_security_enabled
    - routing (block):
        - associated_route_table_id (optional)
        - inbound_route_map_id (optional)
        - outbound_route_map_id (optional)
        - propagated_route_table (optional, block):
            - labels (optional)
            - route_table_ids (optional)
        - static_vnet_local_route_override_criteria (optional)
        - static_vnet_propagate_static_routes_enabled (optional)
        - static_vnet_route (optional, block):
            - address_prefixes (optional)
            - name (optional)
            - next_hop_ip_address (optional)
EOT

  type = map(object({
    name                      = string
    remote_virtual_network_id = string
    virtual_hub_id            = string
    internet_security_enabled = optional(bool)
    routing = optional(object({
      associated_route_table_id = optional(string)
      inbound_route_map_id      = optional(string)
      outbound_route_map_id     = optional(string)
      propagated_route_table = optional(object({
        labels          = optional(set(string))
        route_table_ids = optional(list(string))
      }))
      static_vnet_local_route_override_criteria   = optional(string)
      static_vnet_propagate_static_routes_enabled = optional(bool)
      static_vnet_route = optional(list(object({
        address_prefixes    = optional(set(string))
        name                = optional(string)
        next_hop_ip_address = optional(string)
      })))
    }))
  }))
  # --- Unconfirmed validation candidates, derived from azurerm_virtual_hub_connection's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    [from validate.VirtualHubConnectionName] !regexp.MustCompile(`^[\da-zA-Z][-_.\da-zA-Z]{0,78}[_\da-zA-Z]$`).MatchString(value)
  # path: virtual_hub_id
  #   source:    [from virtualwans.ValidateVirtualHubID] !ok
  # path: virtual_hub_id
  #   source:    [from virtualwans.ValidateVirtualHubID] err != nil
  # path: remote_virtual_network_id
  #   source:    [from commonids.ValidateVirtualNetworkID] !ok
  # path: remote_virtual_network_id
  #   source:    [from commonids.ValidateVirtualNetworkID] err != nil
  # path: routing.associated_route_table_id
  #   source:    [from virtualwans.ValidateHubRouteTableID] !ok
  # path: routing.associated_route_table_id
  #   source:    [from virtualwans.ValidateHubRouteTableID] err != nil
  # path: routing.inbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] !ok
  # path: routing.inbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] err != nil
  # path: routing.outbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] !ok
  # path: routing.outbound_route_map_id
  #   source:    [from virtualwans.ValidateRouteMapID] err != nil
  # path: routing.propagated_route_table.labels[*]
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: routing.propagated_route_table.route_table_ids[*]
  #   source:    [from virtualwans.ValidateHubRouteTableID] !ok
  # path: routing.propagated_route_table.route_table_ids[*]
  #   source:    [from virtualwans.ValidateHubRouteTableID] err != nil
  # path: routing.static_vnet_local_route_override_criteria
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: routing.static_vnet_route.name
  #   condition: length(value) > 0
  #   message:   must not be empty
  # path: routing.static_vnet_route.address_prefixes[*]
  #   source:    validation.IsCIDR(...) - no translation rule yet, add one
  # path: routing.static_vnet_route.next_hop_ip_address
  #   source:    validation.IsIPv4Address(...) - no translation rule yet, add one
}

