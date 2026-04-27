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

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.service_name}-${var.deployment_environment}-001"
  location = var.location
}

output "resource_group_id" {
  value = azurerm_resource_group.this.id
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}
