# Creates Identity
resource "azurerm_user_assigned_identity" "identity" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
}

# Creates Role Assignment
resource "azurerm_role_assignment" "assignement" {
  count                = length(var.scope_id_list)
  scope                = var.scope_id_list[count.index]
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_user_assigned_identity.identity.principal_id
}

# Client Id Used for identity binding
output "identity_client_id" {
  value = azurerm_user_assigned_identity.identity.client_id
}

# Resource Id Used for identity binding
output "identity_resource_id" {
  value = azurerm_user_assigned_identity.identity.id
}
