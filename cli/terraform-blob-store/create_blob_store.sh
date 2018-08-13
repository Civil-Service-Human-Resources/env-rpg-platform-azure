#!/bin/bash
##
# The blob storage for terraform state - rpg
##

set -eo pipefail

suffix=build-terraform
azure_default_region=uksouth

echo "##Creating the resource group: rpg-rg-${suffix}"
az group create \
  --location ${azure_default_region} \
  --name rpg-rg-${suffix} \
  --tags service_id=rpg \
          name=rpg-rg-${suffix} \
          environment=build \
          deployed_by=$(whoami) \
          logical_name=build-terraform \
          environment_branch=$(git rev-parse --abbrev-ref HEAD) \
          environment_commit=$(git rev-parse --verify HEAD)

echo "##Creating the storage account: rpgsabuildterraform"
# storage accounts only allow numeric and lowercase
az storage account create \
  --name rpgsabuildterraform \
  --resource-group rpg-rg-${suffix} \
  --tags service_id=rpg \
          name=rpg-sa-${suffix} \
          environment=build \
          deployed_by=$(whoami) \
          logical_name=build-terraform \
          environment_branch=$(git rev-parse --abbrev-ref HEAD) \
          environment_commit=$(git rev-parse --verify HEAD)

echo "##Creating the storage container: rpg-sc-${suffix}"
az storage container create \
  --name rpg-sc-${azure_default_region}-${suffix} \
  --account-name rpgsabuildterraform \
  --public-access off 
#tags not currently an option for storage container
