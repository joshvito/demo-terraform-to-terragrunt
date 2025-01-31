terraform {
  source = "${get_parent_terragrunt_dir()}/../modules//app-service"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependencies {
  paths = ["../rg", "../plan"]
}

dependency "rg" {
  config_path = "../rg"

  mock_outputs = {
    resource_group_name = "fake-resource-group"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

dependency "plan" {
  config_path = "../plan"

  mock_outputs = {
    # service_plan_id = "fake-plan-id"
    service_plan_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Web/serverFarms/serverFarmValue"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

inputs = {
  service_plan_id = dependency.plan.outputs.service_plan_id
  resource_group_name = dependency.rg.outputs.resource_group_name
}

prevent_destroy = true
