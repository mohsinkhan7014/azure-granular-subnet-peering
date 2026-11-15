# ==============================================================================
# Central India Infrastructure (VNet 1 - Primary / Hub)
# Address Space: 10.0.0.0/16
# ==============================================================================

# 1. Resource Group
resource "azurerm_resource_group" "central_india" {
  name     = var.central_india_rg_name
  location = var.central_india_location

  tags = {
    Environment = "Demonstration"
    Region      = "Central India"
    Purpose     = "Subnet-Level-VNet-Peering"
  }
}

# 2. Virtual Network
resource "azurerm_virtual_network" "central_india" {
  name                = var.central_india_vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.central_india.location
  resource_group_name = azurerm_resource_group.central_india.name
  tags                = azurerm_resource_group.central_india.tags
}

# 3. Subnets
# Subnet 1: PEERED to East US snet-east-app-01
resource "azurerm_subnet" "central_app_01" {
  name                 = "snet-central-app-01"
  resource_group_name  = azurerm_resource_group.central_india.name
  virtual_network_name = azurerm_virtual_network.central_india.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Subnet 2: PEERED to East US snet-east-app-01
resource "azurerm_subnet" "central_app_02" {
  name                 = "snet-central-app-02"
  resource_group_name  = azurerm_resource_group.central_india.name
  virtual_network_name = azurerm_virtual_network.central_india.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Subnet 3: ISOLATED - Not included in peering (Strictly isolated at routing level)
resource "azurerm_subnet" "central_isolated_03" {
  name                 = "snet-central-isolated-03"
  resource_group_name  = azurerm_resource_group.central_india.name
  virtual_network_name = azurerm_virtual_network.central_india.name
  address_prefixes     = ["10.0.3.0/24"]
}
