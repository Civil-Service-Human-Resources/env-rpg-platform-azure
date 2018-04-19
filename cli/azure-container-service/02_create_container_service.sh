#!/bin/bash
##
# Create the container service components.
# 

set -exo pipefail

if [[ "$#" -lt 2 ]]; then
	echo "Usage: <env> <ssh key value>"
	exit 1
fi

export AZURE_ENVIRONMENT=${1}
export ADMIN_USER=containeradmin
export AGENT_COUNT=1
export AGENT_VM_SIZE=Standard_A2

export DNS_PREFIX=rpg-${AZURE_ENVIRONMENT}-container-service
export LOCATION=ukwest
export MASTER_COUNT=1
export MASTER_VM_SIZE=Standard_A1

#export ORCHESTRATOR_VERSION=1.8
export SERVICE_PRINCIPAL="29f08e62-1b08-4612-bc4a-347e6d1deb50" #dev
export CLIENT_SECRET="8ae416e2-ab8a-44da-8617-5514f949d319"
export SSH_KEY_VALUE=${2}

# Get the subnet IDs based on the environment and pre set names
net_name_agent=rpg-${AZURE_ENVIRONMENT}-subnet-container-service-agent
net_name_master=rpg-${AZURE_ENVIRONMENT}-subnet-container-service-master

## TODO: we only actually need one call to the API - then manipulate results, 
# rather than 3 calls to API.

AGENT_VNET_SUBNET_ID=$(az network vnet subnet list --vnet-name rpg-dev-vn-container-service \
                            --resource-group rpg-dev-rg-container-service \
                            | jq -r --arg net_name ${net_name_agent} '.[] | select(.name==$net_name).id')

MASTER_VNET_SUBNET_ID=$(az network vnet subnet list --vnet-name rpg-dev-vn-container-service \
                            --resource-group rpg-dev-rg-container-service \
                            | jq -r --arg net_name ${net_name_master} '.[] | select(.name==$net_name).id')

MASTER_SUBNET_RANGE=$(az network vnet subnet list --vnet-name rpg-dev-vn-container-service \
                            --resource-group rpg-dev-rg-container-service \
                            | jq -r --arg net_name ${net_name_master} '.[] | select(.name==$net_name).addressPrefix' \
                            | cut -d '/' -f 1 \
                            | awk -F. '{print $1"."$2"."$3"." $NF+4}')


if [[ -z "${AGENT_VNET_SUBNET_ID}" ]]; then
    echo "Exiting - agent subnet not found"
    exit 1
else
    echo "Agent subnet id: ${AGENT_VNET_SUBNET_ID}"
fi

if [[ -z "${MASTER_VNET_SUBNET_ID}" ]]; then
    echo "Exiting - master subnet not found"
    exit 1
else    
    echo "Master subnet id: ${MASTER_VNET_SUBNET_ID}"
fi

az acs create --name rpg-${AZURE_ENVIRONMENT}-container-service \
                --resource-group rpg-${AZURE_ENVIRONMENT}-rg-container-service \
                --admin-username ${ADMIN_USER} \
                --agent-count ${AGENT_COUNT} \
                --agent-vm-size ${AGENT_VM_SIZE} \
                --agent-vnet-subnet-id ${AGENT_VNET_SUBNET_ID} \
                --dns-prefix ${DNS_PREFIX} \
                --location ${LOCATION} \
                --master-count ${MASTER_COUNT} \
                --master-vm-size ${MASTER_VM_SIZE} \
                --master-vnet-subnet-id ${MASTER_VNET_SUBNET_ID} \
                --orchestrator-type Kubernetes \
		--master-first-consecutive-static-ip ${MASTER_SUBNET_RANGE} \
                --service-principal ${SERVICE_PRINCIPAL} \
                --client-secret ${CLIENT_SECRET} \
                --ssh-key-value "${SSH_KEY_VALUE}" \
                --tags deployedby=$(whoami) environment=${AZURE_ENVIRONMENT} 
                
