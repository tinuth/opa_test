output "resource_group_names" {
  value = [
    azurerm_resource_group.dev_rg.name,
    #azurerm_resource_group.sta_rg.name,
    azurerm_resource_group.prd_rg.name
  ]
}

output "storage_account_names" {
  value = [
    azurerm_storage_account.dev_storage.name,
    azurerm_storage_account.prd_storage.name
  ]
}

output "client_config" {
  value = data.azurerm_client_config.current
}
