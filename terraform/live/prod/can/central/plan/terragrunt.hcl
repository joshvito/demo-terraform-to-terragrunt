terraform {
  source = "${get_parent_terragrunt_dir()}/../modules//service-plan"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependencies {
  paths = ["../rg"]
}

dependency "rg" {
  config_path = "../rg"

  mock_outputs = {
    resource_group_name = "fake-resource-group"
    resource_group_id = "fake-group-id"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

inputs = {
  resource_group_name = dependency.rg.outputs.resource_group_name
}

prevent_destroy = true
