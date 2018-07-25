#!/bin/bash
##
# Create a clamav container instance

export LOCATION=westeurope
export ENVIRONMENT=${1}
export RESOURCE_GROUP=rpg-${ENVIRONMENT}-rg-clamav
export IMAGE=quay.io/ukhomeofficedigital/clamav:latest

readonly PERMITTED_ENVS=(
    dev
    prod
)

if [[ "$#" -lt 1 ]]; then
    echo "Usage "${BASH_SOURCE[0]}" "${PERMITTED_ENVS[@]}" "
    exit 1
fi

az container create \
        --image ${IMAGE} \
        --name rpg-${ENVIRONMENT}-clamav \
        --resource-group ${RESOURCE_GROUP} \
        --cpu 1 \
        --dns-name-label rpg-${ENVIRONMENT}-clamav \
        --location ${LOCATION} \
        --memory 1 \
        --os-type Linux \
        --ports 3310 \
        --restart-policy Always 
