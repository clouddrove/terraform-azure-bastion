#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = "app"
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = "app-test"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(string)
  default     = ["name", "environment"]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "managedby" {
  type        = string
  default     = "CloudDrove"
  description = "ManagedBy, eg ''."
}


variable "resource_group_name" {
  type        = string
  default     = null
  description = "A container that holds related resources for an Azure solution"
}

variable "location" {
  type        = string
  default     = "Canada Central"
  description = "A location the resources"
}

variable "virtual_network_name" {
  type        = string
  default     = null
  description = "The name of the virtual network"
}

variable "public_ip_allocation_method" {
  type        = string
  default     = "Static"
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic"

}

variable "public_ip_sku" {
  type        = string
  default     = "Standard"
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic"
}

variable "azure_bastion_subnet_address_prefix" {
  type        = list(any)
  default     = []
  description = "The address prefix to use for the Azure Bastion subnet"
}

variable "enable_copy_paste" {
  type        = bool
  default     = true
  description = "Is Copy/Paste feature enabled for the Bastion Host?"
}

variable "enable_file_copy" {
  type        = bool
  default     = false
  description = "Is File Copy feature enabled for the Bastion Host. Only supported whne `sku` is `Standard`"
}

variable "bastion_host_sku" {
  type        = string
  default     = "Basic"
  description = "The SKU of the Bastion Host. Accepted values are `Basic` and `Standard`"
}

variable "enable_ip_connect" {
  type        = bool
  default     = false
  description = "Is IP Connect feature enabled for the Bastion Host?"
}

variable "scale_units" {
  type        = number
  default     = 2
  description = "The number of scale units with which to provision the Bastion Host. Possible values are between `2` and `50`. `scale_units` only can be changed when `sku` is `Standard`. `scale_units` is always `2` when `sku` is `Basic`."
}

variable "enable_shareable_link" {
  type        = bool
  default     = false
  description = "Is Shareable Link feature enabled for the Bastion Host. Only supported whne `sku` is `Standard`"
}

variable "enable_tunneling" {
  type        = bool
  default     = false
  description = "Is Tunneling feature enabled for the Bastion Host. Only supported whne `sku` is `Standard`"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-azure-bastion.git"
  description = "Terraform current module repo"
}

variable "ddos_protection_mode" {
  type        = string
  default     = "VirtualNetworkInherited"
  description = "The DDoS protection mode of the public IP"
}

variable "ddos_protection_plan_id" {
  type        = string
  default     = null
  description = "The ID of the DDoS protection plan associated with the Public IP"
}

variable "zone" {
  type        = string
  default     = null
  description = "The Zone for the resources (e.g., `1`, `2`, `3`)."
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "The domain name label for the Azure Bastion Service host. Leave empty for no label."
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "The ID of the Subnet where this Network Interface should be located in."
}

## enable diagnostic setting
variable "log_analytics_destination_type" {
  type        = string
  default     = "AzureDiagnostics"
  description = "Possible values are AzureDiagnostics and Dedicated, default to AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
}

variable "retention_policy_enabled" {
  type        = bool
  default     = false
  description = "Is this Retention Policy enabled?"
}

variable "diagnostic_log_days" {
  type        = number
  default     = "90"
  description = " The number of days for which this Retention Policy should apply."
}

variable "Metric_enable" {
  type        = bool
  default     = true
  description = "Is this Diagnostic Metric enabled? Defaults to true."
}

variable "diagnostic_setting_enable" {
  type    = bool
  default = true
}

variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "category" {
  type        = string
  default     = null
  description = " The name of a Diagnostic Log Category Group for this Resource."
}

variable "log_enabled" {
  type        = string
  default     = true
  description = " Is this Diagnostic Log enabled? Defaults to true."
}

variable "storage_account_id" {
  type        = string
  default     = null
  description = "The ID of the Storage Account where logs should be sent."
}

variable "eventhub_name" {
  type        = string
  default     = null
  description = "Specifies the name of the Event Hub where Diagnostics Data should be sent."
}

variable "eventhub_authorization_rule_id" {
  type        = string
  default     = null
  description = "Specifies the ID of an vent Hub Namespace Authorization Rule used to send Diagnostics Data."
}

variable "metric_enabled" {
  type        = bool
  default     = true
  description = "Is this Diagnostic Metric enabled? Defaults to True."
}

variable "pip_logs" {
  type = object({
    enabled        = bool
    category       = optional(list(string))
    category_group = optional(list(string))
  })

  default = {
    enabled        = true
    category_group = ["AllLogs"]
  }
}
