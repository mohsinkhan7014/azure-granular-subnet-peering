# ==============================================================================
# Authentication Variables
# ==============================================================================

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Azure Service Principal Application (Client) ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  sensitive   = true
}

# ==============================================================================
# Regional Infrastructure Variables
# ==============================================================================

# Central India (VNet 1)
variable "central_india_location" {
  description = "Azure Region for Central India resources"
  type        = string
  default     = "Central India"
}

variable "central_india_rg_name" {
  description = "Resource Group name for Central India"
  type        = string
  default     = "rg-central-india-peering"
}

variable "central_india_vnet_name" {
  description = "Virtual Network name for Central India"
  type        = string
  default     = "vnet-central-india"
}

# East US (VNet 2)
variable "east_us_location" {
  description = "Azure Region for East US resources"
  type        = string
  default     = "East US"
}

variable "east_us_rg_name" {
  description = "Resource Group name for East US"
  type        = string
  default     = "rg-east-us-peering"
}

variable "east_us_vnet_name" {
  description = "Virtual Network name for East US"
  type        = string
  default     = "vnet-east-us"
}

# Legacy variable compatibility (optional)
variable "resource_group_name" {
  description = "Default resource group name fallback"
  type        = string
  default     = "rg-central-india-peering"
}

variable "location" {
  description = "Default location fallback"
  type        = string
  default     = "Central India"
}
