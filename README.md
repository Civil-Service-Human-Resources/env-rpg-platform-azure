# env-rpg-platform-azure
A set of scripts to provision the rpg platform components on Azure

## Code
### cli
A set of one time CLI scripts to create resources outside (or before) terraform

### tf
Terraform scripts

## Naming conventions
To be confirmed.

possibly something like:

rpg-\<object type\>-\<component\>

so

rpg-rg-candidate-interface-db
rpg - resource group - candidate-interface-db


## Assumptions
We will create all our components in uk south.

staging account will hold dev, test

## Tags
Standard list of tags for all components

| Name                      | Description           | Example   |
| -------------             | -------------         | -----     |
| service_id                | RPG                   | rpg       |
| name                      | Component             |          |
| environment               | Logical environment   | dev       |
| deployed_by               | Feed in the user ID   | jenkins   |
| logical_name              |                       |           |
| environment_branch       | The git branch used to apply change | develop|
| environment_commit       | The git commit hash to apply change | 36e7e78c5a2ae3dc0337b08676c637f4524762d5|
