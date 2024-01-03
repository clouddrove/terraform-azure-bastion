module "labels" {
  source      = "clouddrove/labels/azure"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}

#---------------------------------------------
# Public IP for Azure Bastion Service
#---------------------------------------------
resource "azurerm_public_ip" "pip" {
  count                   = var.enabled ? 1 : 0
  name                    = format("%s-bastion-ip", module.labels.id)
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = var.public_ip_allocation_method
  sku                     = var.public_ip_sku
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  zones                   = var.zone != null ? [var.zone] : []
  domain_name_label       = var.domain_name_label != null ? var.domain_name_label : null
  tags                    = module.labels.tags
}

#---------------------------------------------
# Azure Bastion Service host
#---------------------------------------------
resource "azurerm_bastion_host" "main" {
  count = var.enabled ? 1 : 0

  name                   = format("%s-bastion", module.labels.id)
  location               = var.location
  resource_group_name    = var.resource_group_name
  copy_paste_enabled     = var.enable_copy_paste
  file_copy_enabled      = var.bastion_host_sku == "Standard" ? var.enable_file_copy : null
  sku                    = var.bastion_host_sku
  ip_connect_enabled     = var.enable_ip_connect
  scale_units            = var.bastion_host_sku == "Standard" ? var.scale_units : 2
  shareable_link_enabled = var.bastion_host_sku == "Standard" ? var.enable_shareable_link : null
  tunneling_enabled      = var.bastion_host_sku == "Standard" ? var.enable_tunneling : null
  tags                   = module.labels.tags

  ip_configuration {
    name                 = format("%s-network", module.labels.id)
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.pip[0].id
  }
}

#---------------------------------------------
# Azure Monitor Diagnostic Settings for Bastion
#---------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "bastion-diagnostic" {
  count                          = var.enabled && var.diagnostic_setting_enable ? 1 : 0
  name                           = format("%s-bastion-diagnostic-log", module.labels.id)
  target_resource_id             = azurerm_bastion_host.main[0].id
  storage_account_id             = var.storage_account_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type
  dynamic "enabled_log" {
    for_each = var.log_enabled ? ["allLogs"] : []
    content {
      category_group = enabled_log.value
    }
  }
  dynamic "metric" {
    for_each = var.metric_enabled ? ["AllMetrics"] : []
    content {
      category = metric.value
      enabled  = true
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}

#---------------------------------------------
# Azure Monitor Diagnostic Settings for public 
#---------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "pip_diagnostic" {
  count                          = var.enabled && var.diagnostic_setting_enable ? 1 : 0
  name                           = format("%s-bastion-pip-diagnostic-log", module.labels.id)
  target_resource_id             = azurerm_public_ip.pip[0].id
  storage_account_id             = var.storage_account_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type
  dynamic "metric" {
    for_each = var.metric_enabled ? ["AllMetrics"] : []
    content {
      category = metric.value
      enabled  = true
    }
  }
  dynamic "enabled_log" {
    for_each = var.pip_logs.enabled ? var.pip_logs.category != null ? var.pip_logs.category : var.pip_logs.category_group : []
    content {
      category       = var.pip_logs.category != null ? enabled_log.value : null
      category_group = var.pip_logs.category == null ? enabled_log.value : null
    }
  }

  lifecycle {
    ignore_changes = [log_analytics_destination_type]
  }
}





