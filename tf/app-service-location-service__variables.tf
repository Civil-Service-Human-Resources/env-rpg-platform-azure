variable "app-service-location-service__docker_image" {
    type        = "string"
    default     = "cshrrpg.azurecr.io/location-service"
}

variable "app-service-location-service__docker_image_tag" {
    type        = "string"
    default     = "latest"
}

variable "app-service-location-service__ENC_LOCATION_SERVICE_GOOGLE_SERVICE_API_KEY" {
    type        = "string"
}

variable "app-service-location-service__ENC_docker_registry_user" {
    type        = "string"
    description = "the ACR user name to pull the image"
}

variable "app-service-location-service__ENC_docker_registry_password" {
    type        = "string"
    description = "the ACR password to pull the image"
}

variable "app-service-location-service__vaultresourcegroup" {
 default = "lpg-prod-keyvault"
}

variable "app-service-location-service__vaultname" {
 default = "lpg-prod-kv"
}

variable "app-service-location-service__existingkeyvaultsecretname" {
 default = "starcshrdigital-pfxsecret"
}

variable "app-service-location-service__certificatename" {
 default = "starcshrdigital"
}

variable "app-service-location-service__ENC_LOCATION_SERVICE_USERNAME" {
    type            = "string"
    description     = "Basic auth credentials a client needs to use to call location service"
}
variable "app-service-location-service__ENC_LOCATION_SERVICE_PASSWORD" {
    type = "string"
    description     = "Basic auth credentials a client needs to use to call location service"
}