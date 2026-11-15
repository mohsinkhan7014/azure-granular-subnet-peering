# ==============================================================================
# East US Infrastructure (VNet 2 - Client / Branch)
# Address Space: 192.168.0.0/16
# ==============================================================================

# 1. Resource Group
resource "azurerm_resource_group" "east_us" {
  name     = var.east_us_rg_name
  location = var.east_us_location

  tags = {
    Environment = "Demonstration"
    Region      = "East US"
    Purpose     = "Subnet-Level-VNet-Peering"
  }
}

# 2. Virtual Network
resource "azurerm_virtual_network" "east_us" {
  name                = var.east_us_vnet_name
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.east_us.location
  resource_group_name = azurerm_resource_group.east_us.name
  tags                = azurerm_resource_group.east_us.tags
}

# 3. Subnets
# Subnet 1: PEERED to Central India snet-central-app-01 and snet-central-app-02
resource "azurerm_subnet" "east_app_01" {
  name                 = "snet-east-app-01"
  resource_group_name  = azurerm_resource_group.east_us.name
  virtual_network_name = azurerm_virtual_network.east_us.name
  address_prefixes     = ["192.168.1.0/24"]
}

# Subnet 2: ISOLATED - Not included in peering (Blocked from Central India)
resource "azurerm_subnet" "east_isolated_02" {
  name                 = "snet-east-isolated-02"
  resource_group_name  = azurerm_resource_group.east_us.name
  virtual_network_name = azurerm_virtual_network.east_us.name
  address_prefixes     = ["192.168.2.0/24"]
}

# Subnet 3: ISOLATED - Not included in peering (Blocked from Central India)
resource "azurerm_subnet" "east_isolated_03" {
  name                 = "snet-east-isolated-03"
  resource_group_name  = azurerm_resource_group.east_us.name
  virtual_network_name = azurerm_virtual_network.east_us.name
  address_prefixes     = ["192.168.3.0/24"]
}
