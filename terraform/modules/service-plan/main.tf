variable "service_name" {
  description = "The name of this service."
  type        = string
}

variable "deployment_environment" {
  description = "The environment that the service is running in."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group these resources live in."
  type        = string
}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "azurerm_service_plan" "this" {
  name                = "asp-${var.service_name}-${var.deployment_environment}-001"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "P1v3"
}

output "service_plan_id" {
  value = azurerm_service_plan.this.id
}
