#https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image

## Heavily borrowed from LPG XAPI - https://raw.githubusercontent.com/Civil-Service-Human-Resources/lpg-terraform-paas/master/modules/learning-locker-xapi/main.tf

variable "application_name_clamav" {
  type    = "string"
  default = "cshr-clamav"
}

resource "azurerm_resource_group" "rg_clamav" {
  name     = "${var.global__service_id}-${var.environment__name}-rg-${var.application_name_clamav}"
  location = "${var.global__region}"
}

data "template_file" "clamav_arm" {
  template = "${file("${path.module}/templates/cshr-clamav.arm.template.json")}"

  vars {
    app-service-cshr-clamav__certificatename  = "${var.app-service-cshr-clamav__certificatename}"
    app-service-cshr-clamav__docker_image     = "${var.app-service-cshr-clamav__docker_image}"
    app-service-cshr-clamav__docker_image_tag = "${var.app-service-cshr-clamav__docker_image_tag}"

    #app-service-cshr-clamav__ENC_docker_registry_password = "${var.app-service-cshr-clmav__ENC_docker_registry_password}"
    #app-service-cshr-clamav__ENC_docker_registry_user     = "${var.app-service-cshr-clamav__ENC_docker_registry_user}"

    app-service-cshr-clamav__existingkeyvaultsecretname = "${var.app-service-cshr-clamav__existingkeyvaultsecretname}"
    app-service-cshr-clamav__vaultname                  = "${var.app-service-cshr-clamav__vaultname}"
    app-service-cshr-clamav__vaultresourcegroup         = "${var.app-service-cshr-clamav__vaultresourcegroup}"
    application_name                                    = "${var.application_name_clamav}"
    app-service-cshr-clamav__WEBSITES_PORT              = "${var.app-service-cshr-clamav__WEBSITES_PORT}"
    environment__name                                   = "${var.environment__name}"
    global__deployed_by                                 = "${var.global__deployed_by}"
    global__environment_commit                          = "${var.global__environment_commit}"
    global__environment_version                         = "${var.global__environment_version}"
    global__region                                      = "${var.global__region}"
    global__service_id                                  = "${var.global__service_id}"
  }
}

resource "azurerm_template_deployment" "cshr_clamav" {
  name                = "${var.global__service_id}-${var.environment__name}-${var.application_name_clamav}"
  resource_group_name = "${azurerm_resource_group.rg_clamav.name}"

  template_body = "${data.template_file.clamav_arm.rendered}"

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg_clamav"]
}
