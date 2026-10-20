data "azurerm_client_config" "current" {}

locals {
  name = var.project_name
}

############################
# Management group hierarchy
############################
resource "azurerm_management_group" "platform" {
  name         = "${local.name}-platform"
  display_name = "${local.name}-platform"
}

resource "azurerm_management_group" "landingzones" {
  name                       = "${local.name}-landingzones"
  display_name               = "${local.name}-landingzones"
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "sandbox" {
  name                       = "${local.name}-sandbox"
  display_name               = "${local.name}-sandbox"
  parent_management_group_id = azurerm_management_group.platform.id
}

############################
# Azure Policy: restrict allowed locations
############################
resource "azurerm_management_group_policy_assignment" "allowed_locations" {
  name                 = "allowed-locations"
  display_name         = "Allowed locations"
  management_group_id  = azurerm_management_group.platform.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = var.allowed_locations
    }
  })
}

############################
# RBAC: Reader at the Landing Zones scope
############################
resource "azurerm_role_assignment" "reader" {
  scope                = azurerm_management_group.landingzones.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}
