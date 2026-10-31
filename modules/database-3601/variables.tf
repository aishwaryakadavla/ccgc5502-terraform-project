variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the PostgreSQL server"
  type        = string
}

variable "server_name" {
  description = "Globally unique PostgreSQL server name"
  type        = string
}

variable "administrator_login" {
  description = "PostgreSQL administrator username"
  type        = string
}

variable "administrator_password" {
  description = "PostgreSQL administrator password"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Common project tags"
  type        = map(string)
}
