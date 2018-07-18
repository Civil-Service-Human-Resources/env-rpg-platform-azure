variable "app-service-cshr-scanning_service__docker_image" {
  type    = "string"
  default = "quay.io/ukhomeofficedigital/scanning_service"
}

variable "app-service-cshr-scanning_service__docker_image_tag" {
  type = "string"
}

variable "app-service-cshr-scanning_service__ENC_docker_registry_user" {
  type        = "string"
  description = "the ACR user name to pull the image"
}

variable "app-service-cshr-scanning_service__ENC_docker_registry_password" {
  type        = "string"
  description = "the ACR password to pull the image"
}

variable "app-service-cshr-scanning_service__vaultresourcegroup" {
  default = "lpg-prod-keyvault"
}

variable "app-service-cshr-scanning_service__vaultname" {
  default = "lpg-prod-kv"
}

variable "app-service-cshr-scanning_service__existingkeyvaultsecretname" {
  default = "starcshrdigital-pfxsecret"
}

variable "app-service-cshr-scanning_service__certificatename" {
  default = "starcshrdigital"
}

variable "app-service-cshr-scanning_service__CSHR_SCANNER_ENDPOINT" {
  type        = "string"
  description = "clamav end point"
}

variable "app-service-cshr-scanning_service__SERVER_PORT" {
  type        = "string"
  description = ""
}

variable "app-service-cshr-scanning_service__SPRING_SECURITY_SERVICE_PASSWORD" {
  type        = "string"
  description = "spring-boot password"
}

variable "app-service-cshr-scanning_service__SPRING_SECURITY_SERVICE_USERNAME" {
  type        = "string"
  description = "spring-boot username"
}
