#!/bin/bash

export LOCATION=westeurope
export ENVIRONMENT=${1}
export RESOURCE_GROUP=rpg-${ENVIRONMENT}-rg-container-instance

export REGISTRY_USERNAME=${2}
export REGISTRY_PASSWORD=${3}

if [[ "$#" -lt 3 ]]; then
    echo "Usage ${0} <environment> <user> <pass>"
    exit 1
fi

az container create \
        --image cshrrpg.azurecr.io/location-service \
        --name rpg-${ENVIRONMENT}-cg-location-service \
        --resource-group ${RESOURCE_GROUP} \
        --cpu 1 \
        --dns-name-label rpg-${ENVIRONMENT}-location-service \
        --environment-variables "LOCATION_SERVICE_GOOGLE_SERVICE_API_KEY=AIzaSyDw51wA5CgK-bf0eIyPY_-e8qMh5fu-Vsc" \
        --location ${LOCATION} \
        --memory 1 \
        --os-type Linux \
        --ports 8989 \
        --restart-policy Always \
        --registry-login-server cshrrpg.azurecr.io \
	--registry-username ${REGISTRY_USERNAME} \
        --registry-password ${REGISTRY_PASSWORD}


        
