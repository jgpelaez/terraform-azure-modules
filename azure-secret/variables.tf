variable "secret_name" {
  type = string
}
variable "is_random" {
  default = false
}
variable "secret_string" {
  default = "{}"
}
variable "metadata" {
  default = {
    team_name   = null
    environment = null
  }
}
variable "tags" {
  default = {}
}

variable "secret_key" {
  default = null
}
variable "not_before_date" {
  default = null
}
variable "expiration_date" {
  default = null
}
variable "key_vault_id" {
  description = "Key vault id"
}
