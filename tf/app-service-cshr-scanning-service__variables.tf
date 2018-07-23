variable "app-service-cshr-scanning-service__docker_image" {
  type    = "string"
  default = "cshrrpg.azurecr.io/cshr-scanning-service"
}

variable "app-service-cshr-scanning-service__docker_image_tag" {
  type = "string"
}

variable "app-service-cshr-scanning-service__ENC_docker_registry_user" {
  type        = "string"
  description = "the ACR user name to pull the image"
}

variable "app-service-cshr-scanning-service__ENC_docker_registry_password" {
  type        = "string"
  description = "the ACR password to pull the image"
}

variable "app-service-cshr-scanning-service__vaultresourcegroup" {
  default = "lpg-prod-keyvault"
}

variable "app-service-cshr-scanning-service__vaultname" {
  default = "lpg-prod-kv"
}

variable "app-service-cshr-scanning-service__existingkeyvaultsecretname" {
  default = "starcshrdigital-pfxsecret"
}

variable "app-service-cshr-scanning-service__certificatename" {
  default = "starcshrdigital"
}

variable "app-service-cshr-scanning-service__AV_SERVICE_PORT" {
  type        = "string"
  description = ""
  default     = "443"
}

variable "app-service-cshr-scanning-service__ENC_SPRING_SECURITY_SERVICE_PASSWORD" {
  type        = "string"
  description = "spring-boot password"
}

variable "app-service-cshr-scanning-service__ENC_SPRING_SECURITY_SERVICE_USERNAME" {
  type        = "string"
  description = "spring-boot username"
}

variable "app-service-cshr-scanning-service__WEBSITES_PORT" {
  type        = "string"
  description = "port to connect to clamav"
  default     = "8080"
}
