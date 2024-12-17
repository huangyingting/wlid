# Create a resource group
resource "azurerm_resource_group" "wlid" {
  name     = "${var.prefix}-${var.environment}"
  location = var.location
}