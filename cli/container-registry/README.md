# container-registry
Create a docker container registry in azure using the az cli

Container registries will be created in a pseudo "build" account/identifier

## List repo response

Result of call to

`az acr list`

is 

```
[
  {
    "adminUserEnabled": false,
    "creationDate": "2018-03-15T13:40:15.194676+00:00",
    "id": "/subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/rpg-build-docker/providers/Microsoft.ContainerRegistry/registries/jameskingstontest",
    "location": "uksouth",
    "loginServer": "jameskingstontest.azurecr.io",
    "name": "jameskingstontest",
    "provisioningState": "Succeeded",
    "resourceGroup": "rpg-build-docker",
    "sku": {
      "name": "Basic",
      "tier": "Basic"
    },
    "storageAccount": {
      "name": "jameskingstontest133931"
    },
    "tags": {},
    "type": "Microsoft.ContainerRegistry/registries"
  }
]
```
