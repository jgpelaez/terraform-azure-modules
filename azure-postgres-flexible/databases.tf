resource "azurerm_postgresql_flexible_server_database" "db" {
  count     = length(var.databases)
  name      = var.databases[count.index].name
  server_id = azurerm_postgresql_flexible_server.postgres-flexible.id
  collation = var.databases[count.index].collation
  charset   = var.databases[count.index].charset
}
