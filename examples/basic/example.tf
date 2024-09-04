provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Bastion module call.
##-----------------------------------------------------------------------------
module "bastion" {
  source              = "./../../"
  name                = "app"
  environment         = "test"
  resource_group_name = "resource_group_name"
  location            = "Central India"
  subnet_id           = "<subnet_id>"

  ##-----------------------------------------------------------------------------
  ## enable diagnostic setting
  ##-----------------------------------------------------------------------------
  diagnostic_setting_enable = false

}
