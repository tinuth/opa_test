package azure.policy
default allow = false
# Allow storage accounts only in Central India
allow if {
  some resource
  resource = input.resource_changes[_]
  resource.type == "azurerm_storage_account"
  location_allowed(resource.change.after.location)
  sku_allowed(resource.change.after.account_tier)
}
# Allowed location: only Central India
location_allowed(location) if {
  location == "centralindia"
}
# Allowed SKUs
sku_allowed(sku) if {
  sku == "Standard"
}
sku_allowed(sku) if {
  sku == "Premium"
}