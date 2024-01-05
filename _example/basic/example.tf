provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Bastion module call.
##-----------------------------------------------------------------------------
module "bastion" {
  depends_on           = [module.resource_group]
  source               = "./../../"
  name                 = "app"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name
  subnet_id            = module.name_specific_subnet.specific_subnet_id[0]

  ##-----------------------------------------------------------------------------
  ## enable diagnostic setting
  ##-----------------------------------------------------------------------------
  diagnostic_setting_enable = false

}
