#https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image

## Heavily borrowed from LPG XAPI - https://raw.githubusercontent.com/Civil-Service-Human-Resources/lpg-terraform-paas/master/modules/learning-locker-xapi/main.tf

variable "application_name_scanning_service" {
  type    = "string"
  default = "cshr-scanning_service"
}

resource "azurerm_resource_group" "rg_scanning_service" {
  name     = "${var.global__service_id}-${var.environment__name}-rg-${var.application_name_scanning_service}"
  location = "${var.global__region}"
}

data "template_file" "scanning_service_arm" {
  template = "${file("${path.module}/templates/cshr-scanning-service.arm.template.json")}"

  vars {
    app-service-cshr-scanning_service__certificatename  = "${var.app-service-cshr-scanning_service__certificatename}"
    app-service-cshr-scanning_service__docker_image     = "${var.app-service-cshr-scanning_service__docker_image}"
    app-service-cshr-scanning_service__docker_image_tag = "${var.app-service-cshr-scanning_service__docker_image_tag}"

    app-service-cshr-scanning_service__ENC_docker_registry_password = "${var.app-service-cshr-clmav__ENC_docker_registry_password}"
    app-service-cshr-scanning_service__ENC_docker_registry_user     = "${var.app-service-cshr-scanning_service__ENC_docker_registry_user}"

    app-service-cshr-scanning_service__CSHR_SCANNER_ENDPOINT            = "${var.app-service-cshr-scanning_service__CSHR_SCANNER_ENDPOINT}"
    app-service-cshr-scanning_service__SERVER_PORT                      = "${var.app-service-cshr-scanning_service__SERVER_PORT}"
    app-service-cshr-scanning_service__SPRING_SECURITY_SERVICE_PASSWORD = "${var.app-service-cshr-scanning_service__SPRING_SECURITY_SERVICE_PASSWORD}"
    app-service-cshr-scanning_service__SPRING_SECURITY_SERVICE_USERNAME = "${var.app-service-cshr-scanning_service__SPRING_SECURITY_SERVICE_USERNAME}"

    app-service-cshr-scanning_service__existingkeyvaultsecretname = "${var.app-service-cshr-scanning_service__existingkeyvaultsecretname}"
    app-service-cshr-scanning_service__vaultname                  = "${var.app-service-cshr-scanning_service__vaultname}"
    app-service-cshr-scanning_service__vaultresourcegroup         = "${var.app-service-cshr-scanning_service__vaultresourcegroup}"
    application_name                                              = "${var.application_name_api}"
    app-service-cshr-scanning_service__WEBSITES_PORT              = "${var.app-service-cshr-scanning_service__WEBSITES_PORT}"
    environment__name                                             = "${var.environment__name}"
    global__deployed_by                                           = "${var.global__deployed_by}"
    global__environment_commit                                    = "${var.global__environment_commit}"
    global__environment_version                                   = "${var.global__environment_version}"
    global__region                                                = "${var.global__region}"
    global__service_id                                            = "${var.global__service_id}"
  }
}

resource "azurerm_template_deployment" "cshr_scanning_service" {
  name                = "${var.global__service_id}-${var.environment__name}-${var.application_name_scanning_service}"
  resource_group_name = "${azurerm_resource_group.rg_scanning_service.name}"

  template_body = "${data.template_file.scanning_service_arm.rendered}"

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg_scanning_service"]
}
