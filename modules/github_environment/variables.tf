variable "environment" {
  type = string
  description = "value of github repository environment name"
}

variable "github_repository_full_name" {
  type = string
  description = "value of github repository full name"
}

variable "azure_client_id" {
  type = string
  description = "value of azure user managed identity client id"
}

variable "azure_subscription_id" {
  type = string
  description = "value of azure subscription id"
}

variable "azure_tenant_id" {
  type = string
  description = "value of azure tenant id"
}

variable "tfstate_resource_group_name" {
  type = string
  description = "value of terraform state resource group name"
}

variable "tfstate_storage_account_name" {
  type = string
  description = "value of terraform state storage account name"
}

variable "tfstate_container_name" {
  type = string
  description = "value of terraform state container name"
}
