variable "app-service-cshr-api__docker_image" {
    type        = "string"
    default     = "cshrrpg.azurecr.io/cshr-api"
}

variable "app-service-cshr-api__docker_image_tag" {
    type        = "string"
}

variable "app-service-cshr-api__ENC_docker_registry_user" {
    type        = "string"
    description = "the ACR user name to pull the image"
}

variable "app-service-cshr-api__ENC_docker_registry_password" {
    type        = "string"
    description = "the ACR password to pull the image"
}
   
# variable "app-service-cshr-api__datasource_url" {
#    type        = "string"
#    description = "jdbc url for postgres instance"    
# }

variable "app-service-cshr-api__ENC_datasource_username" {
    type        = "string"
    description = "user creds for api DB"
}

variable "app-service-cshr-api__ENC_datasource_password" {
    type        = "string"
    description = "user creds for api DB"
}

variable "app-service-cshr-api__vaultresourcegroup" {
 default = "lpg-prod-keyvault"
}

variable "app-service-cshr-api__vaultname" {
 default = "lpg-prod-kv"
}

variable "app-service-cshr-api__existingkeyvaultsecretname" {
 default = "starcshrdigital-pfxsecret"
}

variable "app-service-cshr-api__certificatename" {
 default = "starcshrdigital"
}

variable "app-service-cshr-api__ENC_SEARCH_USERNAME" {
    type = "string"
    description = ""
}

variable "app-service-cshr-api__ENC_SEARCH_PASSWORD" {
    type = "string"
    description = ""    
}

variable "app-service-cshr-api__ENC_CRUD_USERNAME" {
    type = "string"
    description = ""    
}   

variable "app-service-cshr-api__ENC_CRUD_PASSWORD" {
    type = "string"
    description = ""    
}   

variable "app-service-cshr-api__ENC_LOCATION_SERVICE_USERNAME" {
    type = "string"
    description = ""    
}

variable "app-service-cshr-api__ENC_LOCATION_SERVICE_PASSWORD" {
    type = "string"
    description = ""    
} 

variable "app-service-cshr-api__ENC_NOTIFY_SERVICE_TEMPLATE_ID" {
    type = "string"
}

variable "app-service-cshr-api__ENC_NOTIFY_SERVICE_NOTIFY_API_KEY" {
    type = "string"
}

variable "app-service-cshr-api__ENC_NOTIFY_USERNAME" {
    type = "string"
}

variable "app-service-cshr-api__ENC_NOTIFY_PASSWORD" {
    type = "string"
}
 
variable "app-service-cshr-api__SPRING_PROFILES_ACTIVE" {
  type = "string"
  default = "prod"
}

variable "app-service-cshr-api__ENC_AUTHENTICATION_SERVICE_SECRET" {
  type = "string"
}
