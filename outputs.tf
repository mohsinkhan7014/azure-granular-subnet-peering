# ==============================================================================
# Outputs
# ==============================================================================

output "central_india_resource_group" {
  description = "Central India Resource Group"
  value       = azurerm_resource_group.central_india.name
}

output "central_india_vnet_name" {
  description = "Central India Virtual Network Name"
  value       = azurerm_virtual_network.central_india.name
}

output "central_india_vnet_id" {
  description = "Central India Virtual Network ID"
  value       = azurerm_virtual_network.central_india.id
}

output "east_us_resource_group" {
  description = "East US Resource Group"
  value       = azurerm_resource_group.east_us.name
}

output "east_us_vnet_name" {
  description = "East US Virtual Network Name"
  value       = azurerm_virtual_network.east_us.name
}

output "east_us_vnet_id" {
  description = "East US Virtual Network ID"
  value       = azurerm_virtual_network.east_us.id
}

output "peering_verification_commands" {
  description = "Azure CLI commands to verify peering state"
  value = {
    check_east_to_central = "az network vnet peering show --name peer-east-us-to-central-india --resource-group ${azurerm_resource_group.east_us.name} --vnet-name ${azurerm_virtual_network.east_us.name} --query '{State:peeringState, Sync:peeringSyncLevel}' -o table"
    check_central_to_east = "az network vnet peering show --name peer-central-india-to-east-us --resource-group ${azurerm_resource_group.central_india.name} --vnet-name ${azurerm_virtual_network.central_india.name} --query '{State:peeringState, Sync:peeringSyncLevel}' -o table"
  }
}
