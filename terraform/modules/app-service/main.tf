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

variable "service_plan_id" {
  description = "The ID of the service plan this app service will run on."
  type        = string

}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.service_name}-${var.deployment_environment}-001"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {}
}
