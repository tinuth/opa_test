provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "dev_rg" {
  name     = "dev-rg"
  location = "Central India"
}

#resource "azurerm_resource_group" "sta_rg" {
 # name     = "sta-rg"
  #location = var.location
#}

resource "azurerm_resource_group" "prd_rg" {
  name     = "prd-rg"
  location = "Central India"
}

resource "azurerm_storage_account" "dev_storage" {
  name                     = "devstorageacct"
  resource_group_name      = azurerm_resource_group.dev_rg.name
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "dev"
  }
}


resource "azurerm_storage_account" "prd_storage" {
  name                     = "prdstorageacct"
  resource_group_name      = azurerm_resource_group.prd_rg.name
  location                 = "Central India"
  account_tier             = "Premium"
  account_replication_type = "ZRS"
  tags = {
    environment = "prod" 
  }
}
