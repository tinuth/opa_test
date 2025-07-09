provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}


resource "azurerm_resource_group" "dev_rg" {
  name     = "rg-dev"
  location = var.location
}

resource "azurerm_resource_group" "prd_rg" {
  name     = "rg-prd"
  location = var.location
}

resource "azurerm_storage_account" "dev_sa" {
  name                     = "devstorageacct"
  resource_group_name      = azurerm_resource_group.dev_rg.name
  location                 = azurerm_resource_group.dev_rg.location
  account_tier             = var.dev_sku
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "prd_sa_standard" {
  name                     = "prdstoragestd"
  resource_group_name      = azurerm_resource_group.prd_rg.name
  location                 = azurerm_resource_group.prd_rg.location
  account_tier             = var.prd_sku[0]
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "prd_sa_premium" {
  name                     = "prdstorageprem"
  resource_group_name      = azurerm_resource_group.prd_rg.name
  location                 = azurerm_resource_group.prd_rg.location
  account_tier             = var.prd_sku[1]
  account_replication_type = "ZRS"
}

