variable "name" {
  type    = string
  description = "name of the database to be created"
  default = null
}

variable "resource_group_name" {
  type    = string
  description = "resource group name in which this postgres/other services has to be added"
  default = null
}

variable "location" {
  type    = string
  description = "name of the Azure region in which resources has to be created"
  default = null
}

variable "postgres_version" {
  type    = string
  description = "required postgres version to be created"
  default = null
}

variable "environment" {
  description = "name of the environment like dev/prod"
  type = string
}

variable "private_dns_zone_name" {
  description = "Private DNS name to be created for postgres database"
  type = string
}

variable "location_short" {
  description = "Short string for Azure location/region"
  type        = string
}

variable "administrator_login" {
  type    = string
  description = "user login name, admin username will be created "
  default = null
}

variable "storage_mb" {
  type    = string
  description = "size of the postgres database "
  default = null
}

variable "password" {
  type    = string
  description = "postgres database admin password to login"
  default = null
}

variable "sku_type" {
  type    = string
  description = "postgres Azure engine type to provision"
  default = null
}

variable "name_prefix" {
  type    = string
  description = "in case if we want to add the prifix to the postgres datbase"
  default = ""
}

variable "stack" {
  type    = string
  description = "application stack name"
  default = ""
}

variable "backup_retention_days" {
  type    = number
  description = "time periiod in days to store the backup"
  default = null
}

variable "postgres_subnet_name" {
  type    = list(string)
  description = "Name of the subnet in which postgres server has to be created"
  default = null
}

variable "address_prefixes" {
  type    = list(string)
  description = "Address range for the subnet"
  default = null
}

variable "virtual_network_name" {
  type    = string
  description = "Name of the virtual network in which postgres server has to be created"
  default = null
}

variable "high_availability" {
  type    = map(string)
  description = "To enable the HA in different zones"
  default = { mode = "ZoneRedundant" }
}

variable "client_name" {
  description = "Name of client"
  type        = string
  default     = ""
}

variable "subnet_service_endpoints" {
  type    = list(string)
  description = "Azure services names for which the endpoints need to be created in the subnet"
  default = []
}

variable "extra_tags" {
  type        = map(string)
  description = "Map of custom tags"
  default     = {}
}


variable "zonename" {
  type    = string
  description = "DNS zone name in azure"
  default = null
}

variable "vnet_id" {
  type    = string
  description = "Azure virtual network id"
  default = null
}

variable "delegations" {
  type = list(object({
    name               = string,
    service_delegation = map(list(string))
    actions            = list(string)

  }))
  description = "Subnets delegation with service endpoint link"
  default = null
}

variable "start_ip" {
  description = "starting ip adress from which inbound ips starts"
  default = null
}

variable "end_ip" {
  description = "ending ip adress till which inbound ips ends"
  default = null
}

variable "databases" {
  type = list(map(string))
  description = "Subnets delegation with service endpoint link"
  default = null
}