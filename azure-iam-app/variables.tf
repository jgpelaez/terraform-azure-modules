variable "application_name" {

}
variable "owners" {

}
variable "rotate_when_changed" {
  default = null
}
variable "set_password" {
  default = true
}
variable "hide" {
  default = true
}
variable "enterprise" {
  default = true
}
variable "store_credentials_in_secret" {
  default = true
}
variable "credentials_secret_name" {
  default = null
}
variable "extra_secret_fields" {
  description = "If we want to add to the map extra fields"
  default = {}
}
variable "tags" {
  description = "(Optional) A set of tags to apply to the application. Cannot be used together with the feature_tags block."
}
variable "key_vault_id" {
  description = "Key vault id"
}
variable "required_resource_access" {
  default = []
}
variable "required_resource_access_read_all" {
  default = false
}
variable "web_list" {
  description = "(Optional) A web block which configures web related settings for this application"
  default     = []
}
variable "app_roles" {
  description = "A collection of app_role blocks"
  type = list(object({
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    enabled              = bool
    value                = string
  }))
  default = []
}
variable "group_membership_claims" {
  description = "Configures the groups claim issued in a user or OAuth 2.0 access token that the app expects. Possible values are None, SecurityGroup, DirectoryRole, ApplicationGroup or All."
  default = [
    "None",
  ]
}