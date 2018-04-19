#!/bin/bash

export ENVIRONMENT=${1}

if [[ "$#" -lt 1 ]]; then
    echo "Usage ${0} <environment>"
    exit 1
fi

az group delete --name rpg-${ENVIRONMENT}-rg-container-instance