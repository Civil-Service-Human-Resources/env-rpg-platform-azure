#!/bin/bash
# Get credentials for the sevice
# Note: the location of private key MUST be a full location.
# Ie /user/james/Documents/CSHR/keys
# do not use relative paths.

if [[ $# -lt 1 ]]; then
  echo "Usage ./05_get_creds.sh <env - dev, prod> <location of private key>"
  exit 1	
fi

export RESOURCE_GROUP=rpg-${1}-rg-container-service
export CLUSTER_NAME=rpg-${1}-container-service

az acs kubernetes get-credentials --resource-group=${RESOURCE_GROUP} --name=${CLUSTER_NAME} --ssh-key-file=${2} --debug

