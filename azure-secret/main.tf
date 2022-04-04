resource "azurerm_key_vault_secret" "secret" {
  name            = var.secret_name
  value           = var.secret_key != null ? (jsonencode(local.credentials)) : var.is_random ? random_password.random_password[0].result : var.secret_string
  key_vault_id    = var.key_vault_id
  tags            = var.tags
  not_before_date = var.not_before_date
  expiration_date = var.expiration_date
  lifecycle {
    ignore_changes = [
      value,
      version,
    ]
  }
}

resource "random_password" "random_password" {
  count   = var.is_random ? 1 : 0
  length  = 32
  special = false
}

locals {
  credentials = var.secret_key != null ? {
    "${var.secret_key}" = var.is_random ? random_password.random_password[0].result : var.secret_string
  } : {}
}
