# Create a resource group
resource "azurerm_resource_group" "wlid" {
  name     = "${var.prefix}-rg"
  location = var.location
}