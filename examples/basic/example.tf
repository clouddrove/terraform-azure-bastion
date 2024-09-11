provider "azurerm" {
  features {}
  subscription_id = "000000-11111-1223-XXX-XXXXXXXXXXXX"
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
