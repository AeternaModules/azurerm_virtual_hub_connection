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
  validation {
    condition = alltrue([
      for k, v in var.virtual_hub_connections : (
        v.routing == null || (v.routing.propagated_route_table == null || (v.routing.propagated_route_table.labels == null || (alltrue([for x in v.routing.propagated_route_table.labels : length(x) > 0]))))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_hub_connections : (
        v.routing == null || (v.routing.static_vnet_route == null || alltrue([for item in v.routing.static_vnet_route : (item.name == null || (length(item.name) > 0))]))
      )
    ])
    error_message = "must not be empty"
  }
  # Note: 16 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

