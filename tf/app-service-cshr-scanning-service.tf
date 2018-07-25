#https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image

## Heavily borrowed from LPG XAPI - https://raw.githubusercontent.com/Civil-Service-Human-Resources/lpg-terraform-paas/master/modules/learning-locker-xapi/main.tf

variable "application_name_scanning-service" {
  type    = "string"
  default = "cshr-scanning-service"
}

resource "azurerm_resource_group" "rg_scanning-service" {
  name     = "${var.global__service_id}-${var.environment__name}-rg-${var.application_name_scanning-service}"
  location = "${var.global__region}"
}

data "template_file" "scanning-service_arm" {
  template = "${file("${path.module}/templates/cshr-scanning-service.arm.template.json")}"

  vars {
    app-service-cshr-scanning-service__certificatename  = "${var.app-service-cshr-scanning-service__certificatename}"
    app-service-cshr-scanning-service__docker_image     = "${var.app-service-cshr-scanning-service__docker_image}"
    app-service-cshr-scanning-service__docker_image_tag = "${var.app-service-cshr-scanning-service__docker_image_tag}"

    app-service-cshr-scanning-service__ENC_docker_registry_password = "${var.app-service-cshr-scanning-service__ENC_docker_registry_password}"
    app-service-cshr-scanning-service__ENC_docker_registry_user     = "${var.app-service-cshr-scanning-service__ENC_docker_registry_user}"
    app-service-cshr-scanning-service__FILEBEAT_ENVIRONMENT         = "${var.environment__name}"
    app-service-cshr-scanning-service__ENC_FILEBEAT_HOSTS           = "${var.global__ENC_filebeat_hosts}"

    app-service-cshr-scanning-service__AV_SERVICE_HOSTNAME              = "rpg-${var.environment__name}-clamav.westeurope.azurecontainer.io"
    app-service-cshr-scanning-service__AV_SERVICE_PORT                  = "${var.app-service-cshr-scanning-service__AV_SERVICE_PORT}"
    app-service-cshr-scanning-service__SPRING_SECURITY_SERVICE_PASSWORD = "${var.app-service-cshr-scanning-service__ENC_SPRING_SECURITY_SERVICE_PASSWORD}"
    app-service-cshr-scanning-service__SPRING_SECURITY_SERVICE_USERNAME = "${var.app-service-cshr-scanning-service__ENC_SPRING_SECURITY_SERVICE_USERNAME}"

    app-service-cshr-scanning-service__existingkeyvaultsecretname = "${var.app-service-cshr-scanning-service__existingkeyvaultsecretname}"
    app-service-cshr-scanning-service__vaultname                  = "${var.app-service-cshr-scanning-service__vaultname}"
    app-service-cshr-scanning-service__vaultresourcegroup         = "${var.app-service-cshr-scanning-service__vaultresourcegroup}"
    app-service-cshr-scanning-service__SPRING_PROFILES_ACTIVE     = "${var.app-service-cshr-scanning-service__SPRING_PROFILES_ACTIVE}"
    application_name                                              = "${var.application_name_scanning-service}"
    app-service-cshr-scanning-service__WEBSITES_PORT              = "${var.app-service-cshr-scanning-service__WEBSITES_PORT}"
    environment__name                                             = "${var.environment__name}"
    global__deployed_by                                           = "${var.global__deployed_by}"
    global__environment_commit                                    = "${var.global__environment_commit}"
    global__environment_version                                   = "${var.global__environment_version}"
    global__region                                                = "${var.global__region}"
    global__service_id                                            = "${var.global__service_id}"
  }
}

resource "azurerm_template_deployment" "cshr_scanning-service" {
  name                = "${var.global__service_id}-${var.environment__name}-${var.application_name_scanning-service}"
  resource_group_name = "${azurerm_resource_group.rg_scanning-service.name}"

  template_body = "${data.template_file.scanning-service_arm.rendered}"

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg_scanning-service"]
}
