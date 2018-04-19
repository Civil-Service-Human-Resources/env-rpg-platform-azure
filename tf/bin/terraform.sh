#!/bin/bash
# Terraform wrapper utility
# 16 June 2017
# To set the location of the terraform executable, set an environment variable
# called TF_LOCATION

##
# Permitted values supplied on command line

readonly az_regions=(
  uksouth
  ukwest
  westeurope
)

readonly terraform_actions=(
  plan
  apply
  destroy
)

 #
##

function consoleout () {
  echo "terraform.sh: " $1
}

function consoleout_error() {
  echo "terraform.sh: ERROR: ${1} exiting..."
  exit 1
}


base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
config_dir=$(dirname ${base_dir})/bin
parent_dir=$(dirname ${config_dir})


# Check if the encrypted vars environment var is set, if not exit
if [[ -z "${TF_ENCRYPTED_VARS_DIR}" ]]; then
  consoleout_error "TF_ENCRYPTED_VARS_DIR variable not set, exiting."
fi

encrypted_vars_directory=${TF_ENCRYPTED_VARS_DIR}

consoleout "#######################"
consoleout "Terraform wrapper"
consoleout "#######################"
echo

consoleout "Working directory: ${base_dir}"
consoleout "Parent directory : ${parent_dir}"
consoleout "Checking dependencies"

consoleout "TF_LOCATION: ${TF_LOCATION}"

# check storage acccount is set
if [[ -z "${AZURE_STORAGE_ACCOUNT}" ]]; then
  consoleout_error "Set the AZURE_STORAGE_ACCOUNT variable to access TF backend"
fi

# check storage acccount is set
if [[ -z "${AZURE_STORAGE_CONNECTION_STRING}" ]]; then
  consoleout_error "Set the AZURE_STORAGE_CONNECTION_STRING variable to access TF backend"
fi

# Check if the TF_LOCATION has been externally set
if [[ -z "${TF_LOCATION}" ]]; then

  terraform_location=$(which terraform)
  if [[ -z "${terraform_location}" ]]; then
    consoleout_error "Terraform must be installed..."
  else
    consoleout "${terraform_location}"
  fi

else
  terraform_location=${TF_LOCATION}
fi



if [[ $# -ne 3 ]]; then
  echo  "terraform.sh: ERROR: Usage: terraform.sh <" ${terraform_actions[*]} "> <environment_name> <region> exiting..."
else

  ##
  # input variables

  terraform_action=${1}
  environment_name=${2}
  az_region=${3}
  datestamp=$(date +%Y%m%d%H%M%S)

  consoleout "Do plan"
  if [[ " ${terraform_actions[@]} " =~ " ${terraform_action} " ]]; then
    consoleout "About to do: terraform ${terraform_action}"
  else
    consoleout_error "${terraform_action} not a valid terraform action"
  fi

  if [[ -z "${parent_dir}/etc/${az_region}/environment/${environment_name}" ]]; then
    consoleout_error "No config found for ${environment_name}."
  fi

  if [[ " ${az_regions[@]} " =~ " ${az_region} " ]]; then
    consoleout "About to operate in region: ${az_region}"
  else
    consoleout_error "Region ${az_region} not in permitted region list"
  fi

  var_file_environment_param=""
  var_file_global_param=""
  # List the vars files in the directory
  for environment_var_file in ${parent_dir}/etc/${az_region}/environment/${environment_name}/*.tfvars; do
    var_file_environment_param="-var-file=${environment_var_file} ${var_file_environment_param}"
    consoleout "environment tfvars file: ${environment_var_file}"
  done

  # Add any local var files - containing passwords etc - likely to be encrypted and stored seperate
  for encrypted_var_file in ${encrypted_vars_directory}/etc/${az_region}/environment/${environment_name}/*.tfvars; do
    var_file_environment_param="-var-file=${encrypted_var_file} ${var_file_environment_param}"
    consoleout "encrypted/external tf vars file: ${encrypted_var_file}"
  done

  # List the vars files in the global directory
  for global_var_file in ${parent_dir}/etc/${az_region}/global/*.tfvars; do
    var_file_global_param="-var-file=${global_var_file} ${var_file_global_param}"
    consoleout "global tfvars file: ${global_var_file}"
  done

  consoleout "Azure storage container: ${AZURE_STORAGE_CONTAINER}"
  consoleout "Key: ${az_region}-cshr-platform-${environment_name}.tfstate"

  consoleout "Parent dir: ${parent_dir}"


  ${terraform_location} init \
        -backend=true \
        -backend-config "storage_account_name=${AZURE_STORAGE_ACCOUNT}" \
        -backend-config "key=${az_region}-cshr-platform-${environment_name}.tfstate" \
        -backend-config "container_name=${AZURE_STORAGE_CONTAINER}" \
        -backend-config "access_key=${AZURE_TF_CREDS}" \
        ${parent_dir}/ \
        || consoleout_error "running terraform init"

  ${terraform_location} get -update ${parent_dir} || consoleout_error "running terraform get"

  consoleout "Environment var file param: ${var_file_environment_param}"
  consoleout "Global var file param: ${var_file_global_param}"

  # terraform show and terraform plan need extra parameters
  extra_params=""
  case "${terraform_action}" in
    plan)
      extra_params="-out=${parent_dir}/plans/${environment_name}/plan_${datestamp}.out"
      consoleout "plan file location: ${plans_directory}/${environment_name}/plan_${datestamp}.out"
      if [ ! -d "${parent_dir}/plans/${environment_name}/" ]; then
          consoleout "Creating plans directory: ${parent_dir}/plans/${environment_name}/"
          mkdir ${parent_dir}/plans/${environment_name}/
      fi
      ;;
    *)
      ;;
  esac

  consoleout "Parent dir: ${parent_dir}"

  ${terraform_location} ${terraform_action} \
            ${extra_params} \
            ${var_file_environment_param} \
            ${var_file_global_param} \
            -var "global__region=${az_region}" \
            -var "global__account_number=${AWS_ACCOUNT}" \
            -var "global__environment_version=$(git rev-parse --abbrev-ref HEAD)" \
            -var "global__environment_commit=$(git rev-parse HEAD)" \
            -var "global__deployed_by=$(whoami)" \
            -var "global__datestamp=${datestamp}" \
            ${parent_dir} \
            || consoleout_error "running terraform ${terraform_action}"

fi

consoleout Complete
