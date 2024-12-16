data "azurerm_subscription" "sub" {
}

module "github_resource_group" {
  source   = "../modules/resource_group"
  name     = var.github_rg_name
  location = var.location
  tags     = var.tags
}

module "tfstate_backend" {
  source                   = "../modules/tfstate_backend"
  storage_account_name     = var.storage_account_name
  resource_group_name      = module.github_resource_group.name
  location                 = var.location
  tags                     = var.tags
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  environments             = var.environments
  container_name_prefix    = var.container_name_prefix
}

module "gh_usi" {
  source   = "../modules/user_assigned_identity"
  name     = var.gh_uai_name
  location = var.location
  rg_name  = module.github_resource_group.name
  tags     = var.tags
}

module "tfstate_role_assignment" {
  source       = "../modules/role_assignment"
  principal_id = module.gh_usi.user_assinged_identity_principal_id
  role_name    = "Storage Blob Data Contributor"
  scope_id     = module.tfstate_backend.id
}

module "sub_owner_role_assignment" {
  source       = "../modules/role_assignment"
  principal_id = module.gh_usi.user_assinged_identity_principal_id
  role_name    = var.owner_role_name
  scope_id     = data.azurerm_subscription.sub.id
}

module "gh_federated_credential-pr" {
  source                             = "../modules/federated_identity_credential"
  federated_identity_credential_name = "${var.github_organization_target}-${var.github_repository}-pr"
  rg_name                            = module.github_resource_group.name
  user_assigned_identity_id          = module.gh_usi.user_assinged_identity_id
  subject                            = "repo:${var.github_organization_target}/${var.github_repository}:pull_request"
  audience_name                      = local.default_audience_name
  issuer_url                         = local.github_issuer_url
}

module "gh_federated_credential" {
  for_each                           = toset(var.environments)
  source                             = "../modules/federated_identity_credential"
  federated_identity_credential_name = "${var.github_organization_target}-${var.github_repository}-${each.key}"
  rg_name                            = module.github_resource_group.name
  user_assigned_identity_id          = module.gh_usi.user_assinged_identity_id
  subject                            = "repo:${var.github_organization_target}/${var.github_repository}:environment:${each.key}"
  audience_name                      = local.default_audience_name
  issuer_url                         = local.github_issuer_url
}

module "github_environment" {
  for_each                     = toset(var.environments)
  source                       = "../modules/github_environment"
  environment                  = each.key
  github_repository_full_name  = "${var.github_organization_target}/${var.github_repository}"
  azure_client_id              = module.gh_usi.user_assinged_identity_client_id
  azure_subscription_id        = data.azurerm_subscription.sub.subscription_id
  azure_tenant_id              = data.azurerm_subscription.sub.tenant_id
  tfstate_resource_group_name  = module.github_resource_group.name
  tfstate_storage_account_name = module.tfstate_backend.storage_account_name
  tfstate_container_name       = "${var.container_name_prefix}-${each.key}"
}
