variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account."
  type        = string
}

variable "container_name" {
  description = "Name of the storage container."
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
  default     = "East US"
}
variable "vnet_name" {
  description = "Name of the Virtual Network."
  type        = string
  default     = "sample-vnet"
}
variable "subnet_name" {
  description = "Name of the subnet."
  type        = string
  default     = "sample-subnet"
}
variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
  default     = "dd3e210c-63cf-4c08-9549-f0ecf074d04e"
}
