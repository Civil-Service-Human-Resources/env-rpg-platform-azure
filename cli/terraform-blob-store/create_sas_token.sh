#!/bin/bash
##
# Get an SAS token for the storage account.
##
#Command
#    az storage account generate-sas: Generates a shared access signature for the account.
#
#Arguments
#    --expiry         [Required]: Specifies the UTC datetime (Y-m-d'T'H:M'Z') at which the SAS
#                                 becomes invalid.
#    --permissions    [Required]: The permissions the SAS grants. Allowed values: (a)dd (c)reate
#                                 (d)elete (l)ist (p)rocess (r)ead (u)pdate (w)rite. Can be combined.
#    --resource-types [Required]: The resource types the SAS is applicable for. Allowed values:
#                                 (s)ervice (c)ontainer (o)bject. Can be combined.
#    --services       [Required]: The storage services the SAS is applicable for. Allowed values:
#                                 (b)lob (f)ile (q)ueue (t)able. Can be combined.



set -exo pipefail

az storage account generate-sas \
  --expiry 2019-03-23 \
  --permissions acdlpruw \
  --resource-types co \
  --services bf \
  --account-name ${1} \
  --output tsv
