module "argocd_secret" {
  source          = "../azure-secret"
  count           = length(var.secret_names)
  secret_name     = var.secret_names[count.index]
  key_vault_id    = var.key_vault_id
  tags            = var.tags
  is_random       = var.is_random
  secret_string   = var.secret_string
  metadata        = var.metadata
  secret_key      = var.secret_key
  not_before_date = var.secret_key
  expiration_date = var.secret_key
}
