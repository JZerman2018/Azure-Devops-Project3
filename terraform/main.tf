provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.47"
    }
  }
}
terraform {
  backend "azurerm" {
    resource_group_name  = "project3-tstate"
    storage_account_name = "project3tstate"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
    access_key           =  ""
  }
}
module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = var.resource_group
  location             = var.location
}
module "network" {
  source               = "./modules/network"
  address_space        = var.address_space
  location             = var.location
  virtual_network_name = var.virtual_network_name
  application_type     = var.application_type
  resource_type        = "VNET"
  resource_group       = module.resource_group.resource_group_name
  address_prefix_test  = var.address_prefix_test
}

module "nsg-test" {
  source              = "./modules/networksecuritygroup"
  location            = var.location
  application_type    = var.application_type
  resource_type       = "NSG"
  resource_group      = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id_test
  address_prefix_test = var.address_prefix_test
}
module "appservice" {
  source           = "./modules/appservice"
  location         = var.location
  application_type = var.application_type
  resource_type    = "AppService"
  resource_group   = module.resource_group.resource_group_name
}
module "publicip" {
  source           = "./modules/publicip"
  location         = var.location
  application_type = var.application_type
  resource_group   = module.resource_group.resource_group_name
  resource_type    = "publicip"
}

module "vm" {
  source               = "./modules/vm"
  location             = var.location
  application_type     = var.application_type
  resource_type        = "VM"
  resource_group       = module.resource_group.resource_group_name
  subnet_id            = module.network.subnet_id_test
  public_ip_address_id = module.publicip.public_ip_address_id
  admin_username       = var.admin_username
}