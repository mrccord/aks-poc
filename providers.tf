terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.1.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "prod-biz-terraform"
    storage_account_name = "prodterraformstates"
    container_name       = "aks-poc-tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
