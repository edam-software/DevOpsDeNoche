resource "tfe_variable" "subnet" {
  category        = "terraform"
  key             = "subnets"
  value           = replace(jsonencode(var.subnets), "/(\".*?\"):/", "$1 = ")
  hcl             = true
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_variable" "region" {
  category        = "terraform"
  key             = "region"
  value           = var.region
  hcl             = false
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_variable" "project" {
  category        = "terraform"
  key             = "project"
  value           = var.project
  hcl             = false
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_variable" "entorno" {
  category        = "terraform"
  key             = "entorno"
  value           = var.entorno
  hcl             = false
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_variable_set" "region-subnet-env-project" {
  name         = "region-subnet"
  description  = "Variables Compartidas Subnet y Region"
  organization = data.tfe_organization.sic-mundus.name
}

resource "tfe_workspace_variable_set" "vpc-region-subnet" {
  workspace_id    = tfe_workspace.red.id
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_workspace_variable_set" "kubernetes-region-subnet-us-central1-a" {
  workspace_id    = tfe_workspace.kubernetes-us-central1-a.id
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_workspace_variable_set" "kubernetes-region-subnet-us-east1-a" {
  workspace_id    = tfe_workspace.kubernetes-us-central1-b.id
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_workspace_variable_set" "servicios-google-cloud-region-subnet" {
  workspace_id    = tfe_workspace.servicios-google-cloud.id
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}

resource "tfe_workspace_variable_set" "pipeline-region-subnet" {
  workspace_id    = tfe_workspace.pipeline.id
  variable_set_id = tfe_variable_set.region-subnet-env-project.id
}
