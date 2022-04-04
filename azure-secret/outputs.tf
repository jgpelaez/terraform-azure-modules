output "password" {
  description = "Generated random password and stored on secret manager."
  value       =  var.is_random ? azurerm_key_vault_secret.secret.value: null
  sensitive   = true
}