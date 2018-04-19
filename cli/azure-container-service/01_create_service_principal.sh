#!/bin/bash
##
# Create a service principal for the AKS 
# https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest

set -eo pipefail

if [[ "$#" -lt 1 ]]; then
  echo "Usage: ./01_create_service_principal.sh environment"
  echo "Eg: ./01_create_service_principal.sh dev"
  exit 1
fi

SERVICE_PRINCIPAL_NAME=rpg-${1}-service-principal-aks

SP_PASSWD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --query password --output tsv)
SP_APP_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)

echo "Service principal ID: $SP_APP_ID"
echo "Service principal password: $SP_PASSWD"
