variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the data disks"
  type        = string
}

variable "linux_vm_ids" {
  description = "IDs of the three Linux virtual machines"
  type        = map(string)
}

variable "windows_vm_id" {
  description = "ID of the Windows virtual machine"
  type        = string
}

variable "tags" {
  description = "Common project tags"
  type        = map(string)
}
