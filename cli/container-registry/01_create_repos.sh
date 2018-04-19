#!/bin/bash
##
# Check if container registries exist and if not, create them
# Everything created in uksouth region
# https://docs.microsoft.com/en-us/azure/container-registry/container-registry-best-practices
##
# Dependencies
# ------------
# azure cli   -   https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
# jq          - https://stedolan.github.io/jq/download/
#
#

set -eo pipefail

export resource_group=rpg-build-docker
# SKU is the level of service.
export sku=Basic
export azure_default_region=uksouth
export container_registries=(
  cshrrpg
)


if [[ "$(az group exists --name ${resource_group})" == "false" ]]; then
  echo "Creating the resource group: ${resource_group}"
  az group create \
    --location ${azure_default_region} \
    --name ${resource_group} \
    --tags service_id=rpg \
            name=${resource_group} \
            environment=build \
            deployed_by=$(whoami) \
            logical_name=docker-registry \
            environment_branch=$(git rev-parse --abbrev-ref HEAD) \
            environment_commit=$(git rev-parse --verify HEAD)
else
  echo "Resource group ${resource_group} already exists"
fi


for registry in "${container_registries[@]}"; do
  if [[ "$(az acr check-name --name ${registry} --query "nameAvailable")" == "true" ]]; then
    echo "Creating the registry: ${registry}"
    az acr create \
      --name ${registry} \
      --resource-group ${resource_group} \
      --sku Basic

    echo "Adding tags"
    az acr update \
      --name ${registry} \
      --tags service_id=rpg \
              name=${registry} \
              environment=build \
              deployed_by=$(whoami) \
              logical_name=docker-registry-cshrrpg \
              environment_branch=$(git rev-parse --abbrev-ref HEAD) \
              environment_commit=$(git rev-parse --verify HEAD)
  else
    echo "Resource group ${registry} already exists"
  fi
done
