variable "sku" {
  type    = string
  default = "Standard"
}

variable "environment_name" {
  type = string
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "service_principal_app_id" {
  description = "ID of service principal used during K8s cluster creation"
  type        = string
}