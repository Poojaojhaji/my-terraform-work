terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.84.0"
    }
  }
  /* backend "azurerm" {
    resource_group_name  = "Shivam-resourcegroup"
    storage_account_name = "sa11092023"
    container_name       = "tfstate"
    key                  = "Load_Balancer_for_each/prod.terraform.tfstate"
  }*/
}

provider "azurerm" {
  features {

  }
}