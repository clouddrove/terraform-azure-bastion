## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion\_host\_sku | The SKU of the Bastion Host. Accepted values are `Basic` and `Standard` | `string` | `"Basic"` | no |
| ddos\_protection\_mode | The DDoS protection mode of the public IP | `string` | `"VirtualNetworkInherited"` | no |
| ddos\_protection\_plan\_id | The ID of the DDoS protection plan associated with the Public IP | `string` | `null` | no |
| diagnostic\_setting\_enable | n/a | `bool` | `true` | no |
| domain\_name\_label | The domain name label for the Azure Bastion Service host. Leave empty for no label. | `string` | `null` | no |
| enable\_copy\_paste | Is Copy/Paste feature enabled for the Bastion Host? | `bool` | `true` | no |
| enable\_file\_copy | Is File Copy feature enabled for the Bastion Host. Only supported whne `sku` is `Standard` | `bool` | `false` | no |
| enable\_ip\_connect | Is IP Connect feature enabled for the Bastion Host? | `bool` | `false` | no |
| enable\_shareable\_link | Is Shareable Link feature enabled for the Bastion Host. Only supported whne `sku` is `Standard` | `bool` | `false` | no |
| enable\_tunneling | Is Tunneling feature enabled for the Bastion Host. Only supported whne `sku` is `Standard` | `bool` | `false` | no |
| enabled | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"app-test"` | no |
| eventhub\_authorization\_rule\_id | Specifies the ID of an vent Hub Namespace Authorization Rule used to send Diagnostics Data. | `string` | `null` | no |
| eventhub\_name | Specifies the name of the Event Hub where Diagnostics Data should be sent. | `string` | `null` | no |
| label\_order | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(string)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| location | A location the resources | `string` | `"Canada Central"` | no |
| log\_analytics\_destination\_type | Possible values are AzureDiagnostics and Dedicated, default to AzureDiagnostics. When set to Dedicated, logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table. | `string` | `"AzureDiagnostics"` | no |
| log\_analytics\_workspace\_id | n/a | `string` | `null` | no |
| log\_enabled | Is this Diagnostic Log enabled? Defaults to true. | `string` | `true` | no |
| managedby | ManagedBy, eg ''. | `string` | `"CloudDrove"` | no |
| metric\_enabled | Is this Diagnostic Metric enabled? Defaults to True. | `bool` | `true` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `"app"` | no |
| pip\_logs | n/a | <pre>object({<br>    enabled        = bool<br>    category       = optional(list(string))<br>    category_group = optional(list(string))<br>  })</pre> | <pre>{<br>  "category_group": [<br>    "AllLogs"<br>  ],<br>  "description": "Is this Diagnostic logs enabled? Defaults to True.",<br>  "enabled": true<br>}</pre> | no |
| public\_ip\_allocation\_method | Defines the allocation method for this IP address. Possible values are Static or Dynamic | `string` | `"Static"` | no |
| public\_ip\_sku | The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic | `string` | `"Standard"` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-azure-bastion.git"` | no |
| resource\_group\_name | A container that holds related resources for an Azure solution | `string` | `null` | no |
| scale\_units | The number of scale units with which to provision the Bastion Host. Possible values are between `2` and `50`. `scale_units` only can be changed when `sku` is `Standard`. `scale_units` is always `2` when `sku` is `Basic`. | `number` | `2` | no |
| storage\_account\_id | The ID of the Storage Account where logs should be sent. | `string` | `null` | no |
| subnet\_id | The ID of the Subnet where this Network Interface should be located in. | `string` | `null` | no |
| zone | The Zone for the resources (e.g., `1`, `2`, `3`). | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_name | Specifies the name of the bastion host |
| id | Specifies the resource id of the bastion host |

