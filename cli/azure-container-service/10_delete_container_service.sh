#!/bin/bash

export AZURE_ENVIRONMENT=${1}

az acs delete --name rpg-${AZURE_ENVIRONMENT}-container-service \
                --resource-group rpg-${AZURE_ENVIRONMENT}-rg-container-service


