resource "azurerm_postgresql_flexible_server" "postgres-flexible" {
  name = coalesce(
    var.name,
    local.default_name_server,
  )
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgres_version
  administrator_login    = var.administrator_login
  administrator_password = var.password
  storage_mb             = var.storage_mb
  sku_name               = var.sku_type
  backup_retention_days  = var.backup_retention_days
  tags                   = merge(local.default_tags, var.extra_tags)
  delegated_subnet_id    = azurerm_subnet.subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.postgres-priv-dns.id

  dynamic "high_availability" {
    for_each = var.high_availability != null ? var.high_availability : {}
    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = var.zonename
    }
  }

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_private_dns_zone_virtual_network_link.this
  ]

}

# Creation of separate subnet for postgresql flexible server.
resource "azurerm_subnet" "subnet" {
  name                                           = length(var.postgres_subnet_name)
  resource_group_name                            = var.resource_group_name
  address_prefixes                               = var.address_prefixes
  virtual_network_name                           = var.virtual_network_name
  enforce_private_link_endpoint_network_policies = false
  service_endpoints                              = var.subnet_service_endpoints
  delegation {
    name = var.name
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

#creating the private dns zone and linking to vnet zone
resource "azurerm_private_dns_zone" "postgres-priv-dns" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name = coalesce(
    "${var.name}vnetzone.com",
    "${local.default_name_server}vnetzone.com",
  )
  private_dns_zone_name = azurerm_private_dns_zone.postgres-priv-dns.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
}

# creating firewall rules
resource "azurerm_postgresql_flexible_server_firewall_rule" "example" {
  name             = var.name
  server_id        = azurerm_postgresql_flexible_server.postgres-flexible.id
  start_ip_address = var.start_ip
  end_ip_address   = var.end_ip
}
