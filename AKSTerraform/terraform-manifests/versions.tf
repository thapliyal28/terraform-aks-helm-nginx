terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
 /* backend "azurerm" {
    resource_group_name   = "azurerm_resource_group.aks_rg.name"
    storage_account_name  = "var.storage_account_name"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
}*/

}
