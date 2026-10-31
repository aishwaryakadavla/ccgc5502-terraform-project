variable "resource_group_name" {
  description = "Name of the resource group where network resources will be created"
  type        = string
}

variable "location" {
  description = "Azure region for the network resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address prefixes assigned to the subnet"
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "tags" {
  description = "Common tags applied to network resources"
  type        = map(string)
}
