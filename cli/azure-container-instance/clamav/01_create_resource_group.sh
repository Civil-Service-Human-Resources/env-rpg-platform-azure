#!/bin/bash
# create a resource group for the clamav container instance

export LOCATION=westeurope
export ENVIRONMENT=${1}

readonly PERMITTED_ENVS=(
    dev
    prod
)

if [[ "$#" -lt 1 ]]; then
    echo "Usage "${BASH_SOURCE[0]}" "${PERMITTED_ENVS[@]}" "
    exit 1
fi

az group create \
    --location ${LOCATION} \
    --name rpg-${ENVIRONMENT}-rg-clamav \
    --tags "service_id=rpg" \
            "name=rpg-${ENVIRONMENT}-rg-clamav" \
            "environment=${ENVIRONMENT}" \
            "deployed_by=$(whoami)" \
            "logical_name=clamav" \
            "environment_branch=$(git rev-parse --abbrev-ref HEAD)" \
            "environment_version=$(git rev-parse HEAD)"
