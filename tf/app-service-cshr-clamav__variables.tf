variable "app-service-cshr-clamav__docker_image" {
  type    = "string"
  default = "quay.io/ukhomeofficedigital/clamav"
}

variable "app-service-cshr-clamav__docker_image_tag" {
  type = "string"
}

variable "app-service-cshr-clamav__ENC_docker_registry_user" {
  type        = "string"
  description = "the ACR user name to pull the image"
}

variable "app-service-cshr-clamav__ENC_docker_registry_password" {
  type        = "string"
  description = "the ACR password to pull the image"
}

#Need to clarify this
variable "app-service-cshr-clamav__vaultresourcegroup" {
  default = "lpg-prod-keyvault"
}

#Need to clarify this
variable "app-service-cshr-clamav__vaultname" {
  default = "lpg-prod-kv"
}

#Need to clarify this
variable "app-service-cshr-clamav__existingkeyvaultsecretname" {
  default = "starcshrdigital-pfxsecret"
}

variable "app-service-cshr-clamav__certificatename" {
  default = "starcshrdigital"
}

variable "app-service-cshr-clamav__WEBSITES_PORT" {
  type = "string"
  description = "port mapping for the clamAV port to 443"
  default = "3310"
}
