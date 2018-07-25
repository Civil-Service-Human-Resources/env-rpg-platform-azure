#!/bin/bash
##
# Remove the resource group containing clam service

export ENVIRONMENT=${1}

readonly PERMITTED_ENVS=(
    dev
    prod
)

if [[ "$#" -lt 1 ]]; then
    echo "Usage "${BASH_SOURCE[0]}" "${PERMITTED_ENVS[@]}" "
    exit 1
fi

az group delete --name rpg-${ENVIRONMENT}-rg-clamav
