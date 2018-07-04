#!/bin/bash
##
# Create CNAME records

set -eo pipefail

export RG=lpgdomain
export ENV=prod
export ZONE=cshr.digital
export NAMES=(
    rpg-${ENV}-location-service
    rpg-${ENV}-cshr-api
    rpg-${ENV}-cshr-ats-adaptor
)

for name in ${NAMES[@]}; do 
    echo "Creating cname": ${name}
    az network dns record-set cname create --name ${name} --resource-group ${RG} --zone-name ${ZONE} --ttl 300
done

for name in ${NAMES[@]}; do 
    echo "Setting value": ${name}
    az network dns record-set cname set-record --cname ${name}.azurewebsites.net  --record-set-name ${name} --resource-group ${RG} --zone-name ${ZONE}
done

# Create reference to gov paas installed UI.
echo "Creating CNAME for UI"
az network dns record-set cname create --name find-civil-service-jobs --resource-group ${RG} --zone-name ${ZONE} --ttl 300
az network dns record-set cname set-record --cname rpg-ci.cloudapps.digital --record-set-name find-civil-service-jobs --resource-group ${RG} --zone-name ${ZONE}


