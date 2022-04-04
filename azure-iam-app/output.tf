output "application_id" {
  value = azuread_application.application.application_id
}
output "service_principal_object_id" {
  value = azuread_service_principal.application.object_id
}
output "app_role_ids" {
  value = azuread_service_principal.application.app_role_ids
}