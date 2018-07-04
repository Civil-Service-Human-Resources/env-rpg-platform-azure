#https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image

## Heavily borrowed from LPG XAPI - https://raw.githubusercontent.com/Civil-Service-Human-Resources/lpg-terraform-paas/master/modules/learning-locker-xapi/main.tf
# Reference here = https://github.com/Azure/azure-quickstart-templates/tree/master/201-web-app-custom-domain-and-ssl


variable "application_name" {
    type        = "string"
    default     = "location-service"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.global__service_id}-${var.environment__name}-rg-${var.application_name}"
  location = "${var.global__region}"
}

#resource "azurerm_dns_cname_record" "location_service_cname" {
#  name                = "${var.global__service_id}-${var.environment__name}-${var.application_name}"
#  zone_name           = "${var.global__domain}"
#  resource_group_name = "lpgdomain"
#  ttl                 = 300
#  record              = "${var.global__service_id}-${var.environment__name}-${var.application_name}.azurewebsites.net"
#}

data "template_file" "location_service_arm" {
  template = "${file("${path.module}/templates/location-service.arm.template.json")}"
  vars {
      app-service-location-service__certificatename                           = "${var.app-service-location-service__certificatename}"
      app-service-location-service__docker_image                              = "${var.app-service-location-service__docker_image}"
      app-service-location-service__docker_image_tag                          = "${var.app-service-location-service__docker_image_tag}"
      app-service-location-service__ENC_docker_registry_password              = "${var.app-service-location-service__ENC_docker_registry_password}"
      app-service-location-service__ENC_docker_registry_user                  = "${var.app-service-location-service__ENC_docker_registry_user}"
      app-service-location-service__FILEBEAT_ENVIRONMENT                      = "${var.environment__name}"
      app-service-location-service__ENC_FILEBEAT_HOSTS                        = "${var.global__ENC_filebeat_hosts}"
      app-service-location-service__ENC_LOCATION_SERVICE_GOOGLE_SERVICE_API_KEY   = "${var.app-service-location-service__ENC_LOCATION_SERVICE_GOOGLE_SERVICE_API_KEY}"
      app-service-location-service__ENC_LOCATION_SERVICE_PASSWORD             = "${var.app-service-location-service__ENC_LOCATION_SERVICE_PASSWORD}"
      app-service-location-service__ENC_LOCATION_SERVICE_USERNAME             = "${var.app-service-location-service__ENC_LOCATION_SERVICE_USERNAME}"  
      app-service-location-service__existingkeyvaultsecretname                = "${var.app-service-location-service__existingkeyvaultsecretname}"
      app-service-location-service__vaultname                                 = "${var.app-service-location-service__vaultname}"
      app-service-location-service__vaultresourcegroup                        = "${var.app-service-location-service__vaultresourcegroup}"
      application_name                                                        = "${var.application_name}"  
      environment__name                                                       = "${var.environment__name}"
      global__deployed_by                                                     = "${var.global__deployed_by}"
      global__environment_commit                                              = "${var.global__environment_commit}"
      global__environment_version                                             = "${var.global__environment_version}"
      global__region                                                          = "${var.global__region}"
      global__service_id                                                      = "${var.global__service_id}"
  }
}

resource "azurerm_template_deployment" "location_service" {
 name                = "${var.global__service_id}-${var.environment__name}-${var.application_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  template_body = "${data.template_file.location_service_arm.rendered}"

  deployment_mode = "Incremental"
  #depends_on      = ["azurerm_resource_group.rg", "azurerm_dns_cname_record.location_service_cname" ]
  depends_on      = ["azurerm_resource_group.rg" ]
}
