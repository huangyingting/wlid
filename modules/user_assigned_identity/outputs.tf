output "user_assinged_identity_id" {
  value = azurerm_user_assigned_identity.msi.id
  description = "The ID of the User Assigned Identity."
}

output "user_assinged_identity_client_id" {
  value = azurerm_user_assigned_identity.msi.client_id
  description = "The ID of the app associated with the Identity."
}

output "user_assinged_identity_principal_id" {
  value = azurerm_user_assigned_identity.msi.principal_id
  description = "The ID of the Service Principal object associated with the created Identity."
}