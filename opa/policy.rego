package azure.policy

default allow = false

# Main allow rule
allow if {
  resource := input.resource_changes[_]
  resource.type == "azurerm_storage_account"

  location_allowed(resource.change.after.location)
  sku_allowed(resource.change.after.account_tier)
  # Call the corrected rg_location_allowed
  rg_location_allowed(resource.change.after.resource_group_name)
  sku_env_allowed(resource)
}

# Allowed location: only Central India
location_allowed(location) if {
  location == "Central India"
}

# Allowed SKUs
sku_allowed(sku) if {
  sku == "Standard"
}
sku_allowed(sku) if {
  sku == "Premium"
}

# Block 1: Resource Group location must be Central India
# This function now takes the resource group name and looks up its location
rg_location_allowed(resource_group_name) if {
  some i
  # Find the resource group in input.resource_changes
  rg_resource := input.resource_changes[i]
  rg_resource.type == "azurerm_resource_group"
  rg_resource.change.after.name == resource_group_name
  rg_resource.change.after.location == "Central India"
}

# Block 2: SKU must match environment based on tags
sku_env_allowed(resource) if {
  env := resource.change.after.tags.environment
  sku := resource.change.after.account_tier
  env == "prod"
  sku == "Premium"
}

sku_env_allowed(resource) if {
  env := resource.change.after.tags.environment
  sku := resource.change.after.account_tier
  env == "dev"
  sku == "Standard"
}


# Deny reasons for opa eval
deny contains reason if {
  resource := input.resource_changes[_]
  resource.type == "azurerm_storage_account"
  not location_allowed(resource.change.after.location)
  reason := "Storage account location is not Central India"
}

deny contains reason if {
  resource := input.resource_changes[_]
  resource.type == "azurerm_storage_account"
  not sku_allowed(resource.change.after.account_tier)
  reason := "Storage account SKU is not Standard or Premium"
}

# Deny reason for Block 1: Resource Group location
deny contains reason if {
  resource := input.resource_changes[_]
  resource.type == "azurerm_storage_account"
  # Pass the resource group name to the corrected rule
  not rg_location_allowed(resource.change.after.resource_group_name)
  reason := "Resource group location must be Central India for storage accounts"
}

# Deny reason for Block 2: SKU and Environment mismatch
deny contains reason if {
  resource := input.resource_changes[_]
  resource.type == "azurerm_storage_account"
  not sku_env_allowed(resource)
  reason := "SKU must match environment tag: 'prod' requires 'Premium', 'dev' requires 'Standard'"
}