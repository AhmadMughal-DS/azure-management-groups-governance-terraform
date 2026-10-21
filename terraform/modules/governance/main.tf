data "azurerm_client_config" "current" {}

resource "azurerm_management_group" "platform" {
  name         = "${var.name_prefix}-platform"
  display_name = "${var.name_prefix}-platform"
}

resource "azurerm_management_group" "landingzones" {
  name                       = "${var.name_prefix}-landingzones"
  display_name               = "${var.name_prefix}-landingzones"
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "sandbox" {
  name                       = "${var.name_prefix}-sandbox"
  display_name               = "${var.name_prefix}-sandbox"
  parent_management_group_id = azurerm_management_group.platform.id
}

############################
# Azure Policy guardrails
############################
resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "allowed-locations"
  display_name         = "Allowed locations"
  management_group_id  = azurerm_management_group.platform.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  parameters = jsonencode({
    listOfAllowedLocations = { value = var.allowed_locations }
  })
}

# Audit that resources sit in the same region as their resource group
resource "azurerm_management_group_policy_assignment" "rg_location_audit" {
  name                 = "rg-location-audit"
  display_name         = "Audit resource/RG location match"
  management_group_id  = azurerm_management_group.platform.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0a914e76-4921-4c19-b460-a2d36003525a"
}

############################
# RBAC
############################
resource "azurerm_role_assignment" "reader" {
  scope                = azurerm_management_group.landingzones.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}
