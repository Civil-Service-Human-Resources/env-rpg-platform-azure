##
# File containing reference to global variables.

variable "global__region"                { type = "string" }

variable "global__project"               { type = "string" }
variable "global__service_id"            { type = "string" }

variable "global__account_number"        { type = "string" }

variable "global__environment_version"   {
  type = "string"
  description = "The environment project version (git) used in the deployment. Fed in from "
}

variable "global__environment_commit"   {
  type = "string"
  description = "The git commit of the current applied TF state.  Fed in from terraform.sh"
}

variable "global__deployed_by" {
  type = "string"
  description = "The user doing the deployment. Fed in from terraform.sh"
}

variable "global__datestamp" {
  type = "string"
  description = "Date string added to a named resource"
}

variable "global__domain" {
  type = "string"
  description = "Name of the top level domain."
}

variable "global__cidr_whitelist"         { type = "list" }

variable "global__cidr_whitelist_description"         { type = "list" }

variable "global__cidr_azure_app_ips"     { 
  type          = "list"
  description   = "the exit IPs of Azure App Services, for particular region"
}

variable "global__ENC_filebeat_hosts" {
  type = "string"
  description =  "the logit hosts"
}