# Terraform Steps
Branch: master
1. `$ export ARM_SUBSCRIPTION_ID=<subscriptionId>` 
1. `$ terraform init` 
1. `$ terraform plan` 
1. `$ terraform apply` 

## References
* [AzureRm Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
* [Hashicorm Docs](https://developer.hashicorp.com/terraform)

# Terragrunt Steps

Branch: terragrunt-refactor
1. `$ export ARM_SUBSCRIPTION_ID=<subscriptionId>` 
1. `$ terragrunt run-all plan`

## References
* [Terragrunt Docs](https://terragrunt.gruntwork.io/docs/)