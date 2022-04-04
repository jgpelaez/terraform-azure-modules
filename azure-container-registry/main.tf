resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.assigned_identity.id
    ]
  }
}

resource "azurerm_user_assigned_identity" "assigned_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.name
}

