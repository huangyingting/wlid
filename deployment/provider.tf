terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "local" {}
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
