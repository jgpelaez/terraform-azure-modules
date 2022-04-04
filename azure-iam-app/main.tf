resource "azuread_application" "application" {
  display_name = var.application_name
  owners       = var.owners
  dynamic "required_resource_access" {
    for_each = var.required_resource_access_read_all ? [""] : []
    content {
      resource_app_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
      dynamic "resource_access" {
        for_each = var.required_resource_access_read_all ? local.read_resource_access : []
        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }
  dynamic "web" {
    for_each = var.web_list
    content {
      homepage_url  = contains(keys(web.value), "homepage_url")? web.value.homepage_url : null
      logout_url    = contains(keys(web.value), "logout_url")? web.value.logout_url : null
      redirect_uris = contains(keys(web.value), "redirect_uris")? web.value.redirect_uris : null
    }
  }
  dynamic "app_role" {
    for_each = var.app_roles
    content {
      allowed_member_types = app_role.value.allowed_member_types
      description          = app_role.value.description
      display_name         = app_role.value.display_name
      enabled              = app_role.value.enabled
      value                = app_role.value.value
      id                   = random_uuid.app_role_ids[index(var.app_roles, app_role.value)].id
    }
  }
  group_membership_claims = var.group_membership_claims
}
resource "random_uuid" "app_role_ids" {
  count = length(var.app_roles)
}
resource "azuread_service_principal" "application" {
  application_id                = azuread_application.application.application_id
  owners                        = var.owners
  preferred_single_sign_on_mode = "notSupported"
  feature_tags {
    hide       = var.hide
    enterprise = var.enterprise
  }
}
resource "azuread_application_password" "password" {
  count                 = var.set_password ? 1 : 0
  application_object_id = azuread_application.application.object_id
}

module "secret_credentials" {
  source        = "../azure-secret"
  count         = var.store_credentials_in_secret ? 1 : 0
  is_random     = false
  secret_name   = var.credentials_secret_name
  secret_string = jsonencode(merge(var.extra_secret_fields, {
    application_object_id       = azuread_application.application.object_id
    service_principal_object_id = azuread_service_principal.application.object_id
    application_id              = azuread_application.application.application_id
    secret_key                  = azuread_application_password.password[0].value
  }))
  tags          = var.tags
  key_vault_id  = var.key_vault_id
  depends_on = [
    azuread_service_principal.application
  ]
}
locals {
  read_resource_access = [
    {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    },
  ]
}
