#!/bin/bash
## 02_create_service_principals.sh
# Create service principals that can be used to push and pull from ACR
# Script mostly taken from here: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-aci
##
# Dependencies
# ------------
# azure cli   -   https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
#
#

set -eo pipefail

if [[ "$#" -lt 3 ]]; then
  echo "Usage: ./02_create_service_principals.sh <acr repo name> <access | reader or contributor> <identifier>"
  echo "Eg: ./02_create_service_principals.sh cshrrpg reader jenkins"
  echo "Eg: ./02_create_service_principals.sh cshrrpg contributor circleci"
  exit 1
fi

# Modify for your environment. The ACR_NAME is the name of your Azure Container
# Registry, and the SERVICE_PRINCIPAL_NAME can be any unique name within your
# subscription (you can use the default below).
ACR_NAME=${1}
ACR_ROLE=${2}
ACR_IDENTIFIER=${3}

SERVICE_PRINCIPAL_NAME=${ACR_NAME}-acr-service-principal-${ACR_ROLE}-${ACR_IDENTIFIER}

# Obtain the full registry ID for subsequent command args
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)

# Create the service principal with rights scoped to the registry.
# Default permissions are for docker pull access. Modify the '--role'
# argument value as desired:
# reader:      pull only
# contributor: push and pull
# owner:       push, pull, and assign roles
SP_PASSWD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $ACR_REGISTRY_ID --role ${ACR_ROLE} --query password --output tsv)
SP_APP_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)

# Output the service principal's credentials; use these in your services and
# applications to authenticate to the container registry.
echo "Service principal ID: $SP_APP_ID"
echo "Service principal password: $SP_PASSWD"
