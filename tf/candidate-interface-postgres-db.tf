##
# https://azure.microsoft.com/en-gb/pricing/details/postgresql/

resource "azurerm_resource_group" "candidate_interface_db" {
  name     = "rpg-${var.environment__name}-rg-candidate-interface-db"
  location = "${var.global__region}"

  tags {
    service_id           =  "${var.global__service_id}"
    name                 =  "rpg-${var.environment__name}-rg-candidate-interface-db"
    environment          =  "${var.environment__name}"
    deployed_by          =  "${var.global__deployed_by}"
    logical_name         =  "candidate-interface-db"
    environment_branch   =  "${var.global__environment_version}"
    environment_commit   =  "${var.global__environment_commit}"

  }
}

resource "azurerm_postgresql_server" "candidate_interface_db" {
  name                          = "rpg-${var.environment__name}-db-candidate-interface-db"
  location                      = "${var.global__region}"
  resource_group_name           = "${azurerm_resource_group.candidate_interface_db.name}"

  sku {
    name                        = "${var.candidate-interface-postgres-db__sku_name}"
    capacity                    = "${var.candidate-interface-postgres-db__sku_capacity}"
    tier                        = "${var.candidate-interface-postgres-db__sku_tier}"
  }

  administrator_login           = "${var.candidate-interface-postgres-db__ENC_administrator_login}"
  administrator_login_password  = "${var.candidate-interface-postgres-db__ENC_administrator_login_password}"
  version                       = "${var.candidate-interface-postgres-db__version}"
  storage_mb                    = "${var.candidate-interface-postgres-db__storage_mb}"
  ssl_enforcement               = "${var.candidate-interface-postgres-db__ssl_enforcement}"

  tags {
    service_id           =  "${var.global__service_id}"
    name                 =  "rpg-${var.environment__name}-db-candidate-interface-db"
    environment          =  "${var.environment__name}"
    deployed_by          =  "${var.global__deployed_by}"
    logical_name         =  "candidate-interface-db"
    environment_branch   =  "${var.global__environment_version}"
    environment_commit   =  "${var.global__environment_commit}"

  }
}

##
# create ingress rules for the IPs on the whitelist

resource "azurerm_postgresql_firewall_rule" "ingress_fw" {
  count               = "${length(var.global__cidr_whitelist)}"
  name                = "rpg-${var.environment__name}-fw-candidate-interface-db-${var.global__cidr_whitelist_description[count.index]}"
  resource_group_name = "${azurerm_resource_group.candidate_interface_db.name}"
  server_name         = "${azurerm_postgresql_server.candidate_interface_db.name}"
  # Strip off the /32 from address
  start_ip_address    = "${substr(var.global__cidr_whitelist[count.index],0,length(var.global__cidr_whitelist[count.index])-3)}"
  end_ip_address      = "${substr(var.global__cidr_whitelist[count.index],0,length(var.global__cidr_whitelist[count.index])-3)}"
}

resource "azurerm_postgresql_firewall_rule" "ingress_fw_azure_ips" {
  count               = "${length(var.global__cidr_azure_app_ips)}"
  name                = "rpg-${var.environment__name}-fw-candidate-interface-db-azure-app-exit-ip-${count.index}"
  resource_group_name = "${azurerm_resource_group.candidate_interface_db.name}"
  server_name         = "${azurerm_postgresql_server.candidate_interface_db.name}"
  
  start_ip_address    = "${element(split(",",var.global__cidr_azure_app_ips[count.index]),0)}"
  end_ip_address    = "${element(split(",",var.global__cidr_azure_app_ips[count.index]),1)}"
}