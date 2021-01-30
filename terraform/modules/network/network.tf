resource "azurerm_virtual_network" "test" {
  name                 = "test-vnet"
  address_space        = var.address_space
  location             = var.location
  resource_group_name  = var.resource_group
}
resource "azurerm_subnet" "test" {
  name                 = "test-subnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.test.name
  address_prefixes     = var.address_prefix_test
}