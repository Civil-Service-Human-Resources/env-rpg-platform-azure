#!/bin/bash
# create a resource group for the container instances

export LOCATION=westeurope
export ENVIRONMENT=${1}

if [[ "$#" -lt 1 ]]; then
    echo "Usage ${0} <environment>"
    exit 1
fi

az group create \
    --location ${LOCATION} \
    --name rpg-${ENVIRONMENT}-rg-container-instance \
    --tags "service_id=rpg" \
            "name=rpg-${ENVIRONMENT}-rg-container-instance" \
            "environment=${ENVIRONMENT}" \
            "deployed_by=$(whoami)" \
            "logical_name=container_instance" \
            "environment_branch=TBC" \
            "environment_version=TBC"





