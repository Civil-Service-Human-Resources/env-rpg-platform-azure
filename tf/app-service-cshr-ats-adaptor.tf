# #https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image

# ## Heavily borrowed from LPG XAPI - https://raw.githubusercontent.com/Civil-Service-Human-Resources/lpg-terraform-paas/master/modules/learning-locker-xapi/main.tf
# # Reference here = https://github.com/Azure/azure-quickstart-templates/tree/master/201-web-app-custom-domain-and-ssl

variable "application_name_ats" {
  type    = "string"
  default = "cshr-ats-adaptor"
}

resource "azurerm_resource_group" "rg_ats" {
  name     = "${var.global__service_id}-${var.environment__name}-rg-${var.application_name_ats}"
  location = "${var.global__region}"
}

data "template_file" "cshr_ats_adaptor_arm" {
  template = "${file("${path.module}/templates/cshr-ats-adaptor.arm.template.json")}"

  vars {
    app-service-cshr-ats-adaptor__ATS_JOBRUN_HISTORY_DIRECTORY                 = "${var.app-service-cshr-ats-adaptor__ATS_JOBRUN_HISTORY_DIRECTORY}"
    app-service-cshr-ats-adaptor__ATS_JOBRUN_HISTORY_FILE                      = "${var.app-service-cshr-ats-adaptor__ATS_JOBRUN_HISTORY_FILE}"
    app-service-cshr-ats-adaptor__ATS_REQUEST_BATCH_SIZE                       = "${var.app-service-cshr-ats-adaptor__ATS_REQUEST_BATCH_SIZE}"
    app-service-cshr-ats-adaptor__ATS_REQUEST_ENDPOINT                         = "${var.app-service-cshr-ats-adaptor__ATS_REQUEST_ENDPOINT}"
    app-service-cshr-ats-adaptor__certificatename                              = "${var.app-service-cshr-ats-adaptor__certificatename}"
    app-service-cshr-ats-adaptor__CSHR_API_SERVICE_DEPARTMENT_FINDALL_ENDPOINT = "https://${var.global__service_id}-${var.environment__name}-${var.application_name_api}.${var.global__domain}/department"
    app-service-cshr-ats-adaptor__CSHR_API_SERVICE_VACANCY_FINDALL_ENDPOINT    = "https://${var.global__service_id}-${var.environment__name}-${var.application_name_api}.${var.global__domain}/vacancy?page={page}&size={size}"
    app-service-cshr-ats-adaptor__CSHR_API_SERVICE_VACANCY_LOAD_ENDPOINT       = "https://${var.global__service_id}-${var.environment__name}-${var.application_name_api}.${var.global__domain}/vacancy/{id}"
    app-service-cshr-ats-adaptor__CSHR_API_SERVICE_VACANCY_SAVE_ENDPOINT       = "https://${var.global__service_id}-${var.environment__name}-${var.application_name_api}.${var.global__domain}/vacancy/save"
    app-service-cshr-ats-adaptor__CSHR_JOBRUN_AUDIT_BASEFILENAME               = "${var.app-service-cshr-ats-adaptor__CSHR_JOBRUN_AUDIT_BASEFILENAME}"
    app-service-cshr-ats-adaptor__CSHR_JOBRUN_AUDIT_DIRECTORY                  = "${var.app-service-cshr-ats-adaptor__CSHR_JOBRUN_AUDIT_DIRECTORY}"
    app-service-cshr-ats-adaptor__CSHR_JOBRUN_FIXED_DELAY                      = "${var.app-service-cshr-ats-adaptor__CSHR_JOBRUN_FIXED_DELAY}"
    app-service-cshr-ats-adaptor__docker_image                                 = "${var.app-service-cshr-ats-adaptor__docker_image}"
    app-service-cshr-ats-adaptor__docker_image_tag                             = "${var.app-service-cshr-ats-adaptor__docker_image_tag}"
    app-service-cshr-ats-adaptor__ENC_ATS_AUTHENTICATION_TOKEN                 = "${var.app-service-cshr-ats-adaptor__ENC_ATS_AUTHENTICATION_TOKEN}"
    app-service-cshr-ats-adaptor__ENC_ATS_CLIENT_ID                            = "${var.app-service-cshr-ats-adaptor__ENC_ATS_CLIENT_ID}"
    app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_SEARCH_PASSWORD         = "${var.app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_SEARCH_PASSWORD}"
    app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_SEARCH_USERNAME         = "${var.app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_SEARCH_USERNAME}"
    app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_VACANCY_SAVE_PASSWORD   = "${var.app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_VACANCY_SAVE_PASSWORD}"
    app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_VACANCY_SAVE_USERNAME   = "${var.app-service-cshr-ats-adaptor__ENC_CSHR_API_SERVICE_VACANCY_SAVE_USERNAME}"
    app-service-cshr-ats-adaptor__ENC_CSHR_ATS_VENDOR_ID                       = "${var.app-service-cshr-ats-adaptor__ENC_CSHR_ATS_VENDOR_ID}"
    app-service-cshr-ats-adaptor__ENC_docker_registry_password                 = "${var.app-service-cshr-ats-adaptor__ENC_docker_registry_password}"
    app-service-cshr-ats-adaptor__ENC_docker_registry_user                     = "${var.app-service-cshr-ats-adaptor__ENC_docker_registry_user}"
    app-service-cshr-ats-adaptor__ENC_SPRING_SECURITY_SERVICE_PASSWORD         = "${var.app-service-cshr-ats-adaptor__ENC_SPRING_SECURITY_SERVICE_PASSWORD}"
    app-service-cshr-ats-adaptor__ENC_SPRING_SECURITY_SERVICE_USERNAME         = "${var.app-service-cshr-ats-adaptor__ENC_SPRING_SECURITY_SERVICE_USERNAME}"
    app-service-cshr-ats-adaptor__existingkeyvaultsecretname                   = "${var.app-service-cshr-ats-adaptor__existingkeyvaultsecretname}"
    app-service-cshr-ats-adaptor__FILEBEAT_ENVIRONMENT                         = "${var.environment__name}"
    app-service-cshr-ats-adaptor__FILEBEAT_HOSTS                               = "${var.global__ENC_filebeat_hosts}"
    app-service-cshr-ats-adaptor__SLACK_NOTIFICATION_CHANNEL                   = "${var.app-service-cshr-ats-adaptor__ENC_SLACK_NOTIFICATION_CHANNEL}"
    app-service-cshr-ats-adaptor__SLACK_NOTIFICATION_ENDPOINT                  = "${var.app-service-cshr-ats-adaptor__ENC_SLACK_NOTIFICATION_ENDPOINT}"
    app-service-cshr-ats-adaptor__vaultname                                    = "${var.app-service-cshr-ats-adaptor__vaultname}"
    app-service-cshr-ats-adaptor__vaultresourcegroup                           = "${var.app-service-cshr-ats-adaptor__vaultresourcegroup}"
    app-service-cshr-ats-adaptor__SPRING_PROFILES_ACTIVE                       = "${var.app-service-cshr-ats-adaptor__SPRING_PROFILES_ACTIVE}"
    application_name                                                           = "${var.application_name_ats}"
    environment__name                                                          = "${var.environment__name}"
    global__deployed_by                                                        = "${var.global__deployed_by}"
    global__environment_commit                                                 = "${var.global__environment_commit}"
    global__environment_version                                                = "${var.global__environment_version}"
    global__region                                                             = "${var.global__region}"
    global__service_id                                                         = "${var.global__service_id}"
  }
}

resource "azurerm_template_deployment" "cshr_ats_adaptor" {
  name                = "${var.global__service_id}-${var.environment__name}-${var.application_name_ats}"
  resource_group_name = "${azurerm_resource_group.rg_ats.name}"

  template_body = "${data.template_file.cshr_ats_adaptor_arm.rendered}"

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg_ats"]
}
