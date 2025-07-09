
variable "location" {
   type = string
 description = "Allowed location for resources"
}

variable "dev_sku" {
 type = string
 description = "SKU for dev storage account"
}

variable "prd_sku" {
 type = list(string)
 description = "SKUs for prd storage accounts"
}

variable "subscription_id" {
 type= string
 description = "Azure subscription ID"
}

variable "client_id" {
 type = string
 description = "Azure client ID"
}

variable "client_secret" {
 type = string
 description = "Azure client secret"
sensitive = true
}

variable "tenant_id" {
 type = string
description = "Azure tenant ID"
}

