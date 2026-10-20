output "platform_management_group_id" {
  description = "Platform (parent) management group ID"
  value       = azurerm_management_group.platform.id
}

output "landingzones_management_group_id" {
  description = "Landing Zones management group ID"
  value       = azurerm_management_group.landingzones.id
}

output "policy_assignment_id" {
  description = "Allowed-locations policy assignment ID"
  value       = azurerm_management_group_policy_assignment.allowed_locations.id
}
