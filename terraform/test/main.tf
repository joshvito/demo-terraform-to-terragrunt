terraform {
  backend "azurerm" {
    resource_group_name  = "rg-inf-terraform-test-001"
    storage_account_name = "stinfterraformtest001"
    container_name       = "tfstate"
    key                  = "tgplayground.tfstate"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "deployment_environment" {
  description = "The environment that the service is running in."
  type        = string
}

variable "service_name" {
  description = "The name of this service."
  type        = string
}

variable "location" {
  description = "Azure region for resources in this environment."
  type        = string
}

module "rg" {
  source = "../modules/resource-group"

  service_name           = var.service_name
  deployment_environment = var.deployment_environment
  location               = var.location
}

module "plan" {
  source = "../modules/service-plan"

  service_name           = var.service_name
  deployment_environment = var.deployment_environment
  resource_group_name    = module.rg.resource_group_name

  depends_on = [module.rg]
}

module "app" {
  source = "../modules/app-service"

  service_name           = var.service_name
  deployment_environment = var.deployment_environment
  location               = var.location
  resource_group_name    = module.rg.resource_group_name
  service_plan_id        = module.plan.service_plan_id

  depends_on = [module.plan, module.rg]
}
