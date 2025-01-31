terraform {
  source = "${get_parent_terragrunt_dir()}/../modules//resource-group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {}

prevent_destroy = true
