#!/bin/bash
set -e

# Disable Git Bash path conversion on Windows (prevents /subscriptions from becoming C:/Program Files/Git/subscriptions)
export MSYS_NO_PATHCONV=1

# Step 1: Capture Resource IDs (and strip \r from Windows CLI output)
VNET_CENTRAL_ID=${VNET_CENTRAL_ID:-$(az network vnet show -g "rg-central-india-peering" -n "vnet-central-india" --query id -o tsv | tr -d '\r')}
VNET_EAST_ID=${VNET_EAST_ID:-$(az network vnet show -g "rg-east-us-peering" -n "vnet-east-us" --query id -o tsv | tr -d '\r')}

# Step 2: East US -> Central India (1 Subnet -> 2 Subnets)
az network vnet peering create \
  --name "peer-east-us-to-central-india" \
  --resource-group "rg-east-us-peering" \
  --vnet-name "vnet-east-us" \
  --remote-vnet "$VNET_CENTRAL_ID" \
  --allow-vnet-access \
  --peer-complete-vnets false \
  --local-subnet-names "snet-east-app-01" \
  --remote-subnet-names "snet-central-app-01" "snet-central-app-02"

# Step 3: Central India -> East US (2 Subnets -> 1 Subnet)
az network vnet peering create \
  --name "peer-central-india-to-east-us" \
  --resource-group "rg-central-india-peering" \
  --vnet-name "vnet-central-india" \
  --remote-vnet "$VNET_EAST_ID" \
  --allow-vnet-access \
  --peer-complete-vnets false \
  --local-subnet-names "snet-central-app-01" "snet-central-app-02" \
  --remote-subnet-names "snet-east-app-01"
