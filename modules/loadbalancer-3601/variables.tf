variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the load balancer"
  type        = string
}

variable "linux_nic_ids" {
  description = "IDs of the three Linux network interfaces"
  type        = map(string)
}

variable "tags" {
  description = "Common project tags"
  type        = map(string)
}
