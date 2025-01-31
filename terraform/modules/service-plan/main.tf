terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0" //Support for OpenID Connect was added in version 3.7.0 of the Terraform AzureRM provider.
    }
  }
}

provider "azurerm" {
  features {}
}

variable "service_name" {
  description = "The name of this service."
  type        = string
}

variable "deployment_environment" {
  description = "The environment that the service is running in."
  type        = string
}

variable "location" {
  description = "Azure region for resources in this environment."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group these resources live in."
  type        = string
}

resource "azurerm_service_plan" "this" {
  name                = "asp-${var.service_name}-${var.deployment_environment}-001"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v3"
}

output "service_plan_id" {
  value = azurerm_service_plan.this.id
}
