# ==============================================================================
# Granular Subnet-Level VNet Peering
# ==============================================================================
# Demonstrates 1-to-2 Selective Subnet Peering:
#   - East US Subnet: snet-east-app-01
#   - Central India Subnets: snet-central-app-01 AND snet-central-app-02
#
# Because peer_complete_virtual_networks_enabled = false, all other subnets
# (snet-east-isolated-02, snet-east-isolated-03, snet-central-isolated-03)
# are completely blocked from routing across the peering link.

# 1. Peering: East US -> Central India
resource "azurerm_virtual_network_peering" "east_us_to_central_india" {
  name                         = "peer-east-us-to-central-india"
  resource_group_name          = azurerm_resource_group.east_us.name
  virtual_network_name         = azurerm_virtual_network.east_us.name
  remote_virtual_network_id    = azurerm_virtual_network.central_india.id
  allow_virtual_network_access = true

  # Granular Subnet Peering settings
  peer_complete_virtual_networks_enabled = false
  local_subnet_names                     = [azurerm_subnet.east_app_01.name]
  remote_subnet_names                    = [
    azurerm_subnet.central_app_01.name,
    azurerm_subnet.central_app_02.name
  ]
}

# 2. Peering: Central India -> East US (Symmetrical Reverse Peering)
resource "azurerm_virtual_network_peering" "central_india_to_east_us" {
  name                         = "peer-central-india-to-east-us"
  resource_group_name          = azurerm_resource_group.central_india.name
  virtual_network_name         = azurerm_virtual_network.central_india.name
  remote_virtual_network_id    = azurerm_virtual_network.east_us.id
  allow_virtual_network_access = true

  # Granular Subnet Peering settings
  peer_complete_virtual_networks_enabled = false
  local_subnet_names                     = [
    azurerm_subnet.central_app_01.name,
    azurerm_subnet.central_app_02.name
  ]
  remote_subnet_names                    = [azurerm_subnet.east_app_01.name]
}

# ==============================================================================
# Optional Shell Script Provisioner (Commented for reference)
# ==============================================================================
# To use the Azure CLI bash script instead of native Terraform, uncomment:
#
# resource "terraform_data" "trigger_peering_script" {
#   depends_on = [
#     azurerm_subnet.central_app_01,
#     azurerm_subnet.central_app_02,
#     azurerm_subnet.central_isolated_03,
#     azurerm_subnet.east_app_01,
#     azurerm_subnet.east_isolated_02,
#     azurerm_subnet.east_isolated_03
#   ]
#
#   provisioner "local-exec" {
#     command     = "subnet_to_subnetpeering.sh"
#     interpreter = ["C:/Program Files/Git/bin/bash.exe"]
#     environment = {
#       VNET_CENTRAL_ID = azurerm_virtual_network.central_india.id
#       VNET_EAST_ID    = azurerm_virtual_network.east_us.id
#     }
#   }
# }

