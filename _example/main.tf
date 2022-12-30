provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "clouddrove/resource-group/azure"
  version = "1.0.0"

  name        = "app"
  environment = "test"
  label_order = ["name", "environment"]
  location    = "Canada Central"
}

#Vnet
module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "clouddrove/virtual-network/azure"
  version    = "1.0.4"

  name        = "app"
  environment = "test"
  label_order = ["name", "environment"]

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.0.0.0/16"
  enable_ddos_pp      = false

  #subnet
  default_name_subnet           = true
  subnet_names                  = ["subnet1"]
  subnet_prefixes               = ["10.0.1.0/24"]
  disable_bgp_route_propagation = false

  # routes
  enabled_route_table = false
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}

module "bastion" {
  depends_on                          = [module.resource_group]
  source                              = "./../"
  name                                = "app"
  environment                         = "test"
  label_order                         = ["name", "environment"]
  resource_group_name                 = module.resource_group.resource_group_name
  azure_bastion_subnet_address_prefix = ["10.0.5.0/24"]
  virtual_network_name                = module.virtual_network.vnet_name[0]
}
