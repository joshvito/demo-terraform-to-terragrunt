locals {
  global_inputs = merge(
    { business_unit = "inf" },
    { service_name = "tftg-playground" },
    { project_details = {
      repo_name = "tftg-playground"}},
    # yamldecode(trim(regex("---(?s:.+)---", file(find_in_parent_folders("readme.md"))), "---"))
  )
  account_hcl = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env_hcl     = try(read_terragrunt_config(find_in_parent_folders("env.hcl")), {})
  region_hcl  = try(read_terragrunt_config(find_in_parent_folders("region.hcl")), {})
}

remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = local.account_hcl.locals.tfstate_resource_group_name
    storage_account_name = local.account_hcl.locals.tfstate_storage_account_name
    container_name       = local.account_hcl.locals.tfstate_container_name
    key                  = format("%s/%s/terraform.tfstate", lower(local.global_inputs.project_details.repo_name), path_relative_to_include())
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  local.global_inputs,
  coalesce(local.account_hcl.inputs, {}),
  try(local.env_hcl.inputs, {}),
  try(local.region_hcl.inputs, {}),
)
