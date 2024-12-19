variable "rg_name" {
  description = "Resource group"
}

variable "location" {
  description = "The location where the resources will be created."
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
}

variable "gh_uai_name" {
  description = "The name of the user-assigned managed identity that's used for GitHub Actions"
  type        = string
}

variable "github_organization" {
  type        = string
  description = "The name of the GitHub organization to target"
}

variable "github_repository" {
  type        = string
  description = "The name of the GitHub repository to target"
}

variable "environments" {
  type    = list(string)
  default = ["dev", "staging", "prod"]
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account"
}

variable "storage_account_tier" {
  type        = string
  description = "The Tier to use for this storage account"
  default     = "Standard"
}

variable "storage_account_replication_type" {
  type        = string
  description = "The Replication Type to use for this storage account"
  default     = "LRS"
}

variable "container_name_prefix" {
  type        = string
  description = "The name of the storage container"
  default     = "tfstate"
}
