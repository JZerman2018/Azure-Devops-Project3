provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tstate$RANDOM"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
    access_key           = var.access_key
  }
}
module "resource_group" {
  source               = ".//modules/resource_group"
  resource_group       = var.resource_group
  location             = var.location
}
module "network" {
  source               = ".//modules/network"
  address_space        = var.address_space
  location             = var.location
  virtual_network_name = var.virtual_network_name
  application_type     = var.application_type
  resource_type        = "NET"
  resource_group       = module.resource_group.resource_group_name
  address_prefix       = var.address_prefix
}

module "nsg-test" {
  source              = ".//modules/networksecuritygroup"
  location            = var.location
  application_type    = var.application_type
  resource_type       = "NSG"
  resource_group      = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id_test
  address_prefix      = var.address_prefix
  prefix              = var.prefix
}
module "appservice" {
  source           = ".//modules/appservice"
  location         = var.location
  application_type = var.application_type
  resource_type    = "AppService"
  resource_group   = module.resource_group.resource_group_name
  prefix           = var.prefix
}
module "publicip" {
  source           = ".//modules/publicip"
  location         = var.location
  prefix           = var.prefix
  resource_group   = module.resource_group.resource_group_name
}

module "virtual_machine" {
  source               = ".//modules/vm"
  location             = var.location
  resource_group       = module.resource_group.resource_group_name
  subnet_id            = module.network.subnet_id_test
  public_ip_address_id = module.publicip.public_ip_address_id
  admin_username       = var.admin_username
  prefix               = var.prefix
}