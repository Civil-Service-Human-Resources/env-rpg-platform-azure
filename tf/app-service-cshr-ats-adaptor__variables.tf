variable "app-service-cshr-ats-adaptor__docker_image" {
    type        = "string"
    default     = "cshrrpg.azurecr.io/cshr-ats-adaptor"
}

variable "app-service-cshr-ats-adaptor__docker_image_tag" {
    type        = "string"
}

variable "app-service-cshr-ats-adaptor__ENC_docker_registry_user" {
    type        = "string"
    description = "the ACR user name to pull the image"
}

variable "app-service-cshr-ats-adaptor__ENC_docker_registry_password" {
    type        = "string"
    description = "the ACR password to pull the image"
}

variable "app-service-cshr-ats-adaptor__vaultresourcegroup" {
 default = "lpg-prod-keyvault"
}

variable "app-service-cshr-ats-adaptor__vaultname" {
 default = "lpg-prod-kv"
}

variable "app-service-cshr-ats-adaptor__existingkeyvaultsecretname" {
 default = "starcshrdigital-pfxsecret"
}

variable "app-service-cshr-ats-adaptor__certificatename" {
 default = "starcshrdigital"
}

variable "app-service-cshr-ats-adaptor__ENC_ATS_AUTHENTICATION_TOKEN" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_ATS_CLIENT_ID" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_VACANCY_SAVE_USERNAME" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_VACANCY_SAVE_PASSWORD" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_SEARCH_USERNAME" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_SEARCH_PASSWORD" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_CSHR_ATS_VENDOR_ID" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_SPRING_SECURITY_SERVICE_USERNAME" { type = "string" }
variable "app-service-cshr-ats-adaptor__ENC_SPRING_SECURITY_SERVICE_PASSWORD" { type = "string" }

variable "app-service-cshr-ats-adaptor__ATS_JOBRUN_HISTORY_DIRECTORY" {
     type = "string" 
     default = "/logs"
}

variable "app-service-cshr-ats-adaptor__ATS_JOBRUN_HISTORY_FILE" { 
    type = "string" 
    default = "jobRunHistory.log"
}

variable "app-service-cshr-ats-adaptor__ATS_REQUEST_BATCH_SIZE" { 
    type = "string" 
    default = "20"
}

variable "app-service-cshr-ats-adaptor__ATS_REQUEST_ENDPOINT" { 
    type = "string" 
}

#variable "app-service-cshr-ats-adaptor__CSHR_API_SERVICE_DEPARTMENT_FINDALL_ENDPOINT" { 
#    type = "string" 
#}
#
#variable "app-service-cshr-ats-adaptor__CSHR_API_SERVICE_VACANCY_SAVE_ENDPOINT" {
#     type = "string" 
#}

variable "app-service-cshr-ats-adaptor__CSHR_JOBRUN_AUDIT_DIRECTORY" {
    type = "string" 
    default = "/logs"
}

variable "app-service-cshr-ats-adaptor__CSHR_JOBRUN_AUDIT_BASEFILENAME" { 
    type = "string" 
    default = "VacancyProcessor.log"
}

variable "app-service-cshr-ats-adaptor__CSHR_JOBRUN_CRON_SCHEDULE" {
    type = "string"
}

variable "app-service-cshr-ats-adaptor__ENC_SLACK_NOTIFICATION_CHANNEL" {
    type = "string"
}
variable "app-service-cshr-ats-adaptor__ENC_SLACK_NOTIFICATION_ENDPOINT" {
    type = "string"
}
