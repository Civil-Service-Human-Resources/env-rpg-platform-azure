#https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image

## Heavily borrowed from LPG XAPI - https://raw.githubusercontent.com/Civil-Service-Human-Resources/lpg-terraform-paas/master/modules/learning-locker-xapi/main.tf

variable "application_name_api" {
    type        = "string"
    default     = "cshr-api"
}

resource "azurerm_resource_group" "rg_api" {
  name     = "${var.global__service_id}-${var.environment__name}-rg-${var.application_name_api}"
  location = "${var.global__region}"
}

resource "azurerm_dns_cname_record" "cname_api" {
  name                = "${var.global__service_id}-${var.environment__name}-${var.application_name_api}"
  zone_name           = "${var.global__domain}"
  resource_group_name = "lpgdomain"
  ttl                 = 300
  record              = "${var.global__service_id}-${var.environment__name}-${var.application_name_api}.azurewebsites.net"
}


data "template_file" "api_arm" {
  template = "${file("${path.module}/templates/cshr-api.arm.template.json")}"
  vars {
    app-service-cshr-api__vaultresourcegroup                        = "${var.app-service-cshr-api__vaultresourcegroup}"
    app-service-cshr-api__vaultname                                 = "${var.app-service-cshr-api__vaultname}"
    app-service-cshr-api__existingkeyvaultsecretname                = "${var.app-service-cshr-api__existingkeyvaultsecretname}"
    app-service-cshr-api__certificatename                           = "${var.app-service-cshr-api__certificatename}"
    app-service-cshr-api__docker_image                              = "${var.app-service-cshr-api__docker_image}"
    app-service-cshr-api__docker_image_tag                          = "${var.app-service-cshr-api__docker_image_tag}"
    app-service-cshr-api__ENC_docker_registry_user                  = "${var.app-service-cshr-api__ENC_docker_registry_user}"
    app-service-cshr-api__ENC_docker_registry_password              = "${var.app-service-cshr-api__ENC_docker_registry_password}"
    location_service_url                                            = "https://${var.global__service_id}-${var.environment__name}-location-service.${var.global__domain}/findlocation/{searchTerm}"
    datasource_url                                                  = "jdbc:postgresql://${azurerm_postgresql_server.candidate_interface_db.fqdn}:5432/cshr?ssl=true"
    application_name                                                = "${var.application_name_api}"  
    environment__name                                               = "${var.environment__name}"
    global__service_id                                              = "${var.global__service_id}"
    global__deployed_by                                             = "${var.global__deployed_by}"
    global__environment_version                                     = "${var.global__environment_version}"
    global__environment_commit                                      = "${var.global__environment_commit}"
    global__region                                                  = "${var.global__region}"
    app-service-cshr-api__ENC_datasource_username                   = "${var.app-service-cshr-api__ENC_datasource_username}"
    app-service-cshr-api__ENC_datasource_password                   = "${var.app-service-cshr-api__ENC_datasource_password}"
    app-service-cshr-api__ENC_SEARCH_USERNAME                   = "${var.app-service-cshr-api__ENC_SEARCH_USERNAME}"
    app-service-cshr-api__ENC_SEARCH_PASSWORD                   = "${var.app-service-cshr-api__ENC_SEARCH_PASSWORD}"
    app-service-cshr-api__ENC_CRUD_USERNAME                     = "${var.app-service-cshr-api__ENC_CRUD_USERNAME}"
    app-service-cshr-api__ENC_CRUD_PASSWORD                     = "${var.app-service-cshr-api__ENC_CRUD_PASSWORD}"
    app-service-cshr-api__ENC_LOCATION_SERVICE_USERNAME         = "${var.app-service-cshr-api__ENC_LOCATION_SERVICE_USERNAME}"
    app-service-cshr-api__ENC_LOCATION_SERVICE_PASSWORD         = "${var.app-service-cshr-api__ENC_LOCATION_SERVICE_PASSWORD}"
  }
}


resource "azurerm_template_deployment" "cshr_api" {
  name                = "${var.global__service_id}-${var.environment__name}-${var.application_name_api}"
  resource_group_name = "${azurerm_resource_group.rg_api.name}"

  template_body = "${data.template_file.api_arm.rendered}"

  deployment_mode = "Incremental"
  depends_on      = ["azurerm_resource_group.rg_api"]
}