resource "tfe_oauth_client" "github_oauth" {
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  organization     = data.tfe_organization.sic-mundus.name
  service_provider = "github"
  oauth_token      = var.oauth_token
}


resource "tfe_workspace" "red" {
  name                  = "devops-days-red-vpc"
  organization          = data.tfe_organization.sic-mundus.name
  description           = "Workspace para Red VPC en us-central1"
  allow_destroy_plan    = true
  auto_apply            = false
  file_triggers_enabled = true
  speculative_enabled   = true
  trigger_prefixes      = ["3_infraestructura_escalable/red/*"]
  working_directory     = "3_infraestructura_escalable/red"

  vcs_repo {
    identifier     = "edam-software/DevOpsDeNoche"
    oauth_token_id = tfe_oauth_client.github_oauth.oauth_token_id
    branch         = "main"
  }
}

resource "tfe_workspace" "kubernetes-us-central1-a" {
  name                  = "devops-days-kubernetes-us-central1-a"
  organization          = data.tfe_organization.sic-mundus.name
  description           = "Workspace para Google Kubernetes Engine us-central1-a"
  allow_destroy_plan    = true
  auto_apply            = false
  file_triggers_enabled = true
  speculative_enabled   = true
  trigger_prefixes      = ["3_infraestructura_escalable/kubernetes/*"]
  working_directory     = "3_infraestructura_escalable/kubernetes"

  vcs_repo {
    identifier     = "edam-software/DevOpsDeNoche"
    oauth_token_id = tfe_oauth_client.github_oauth.oauth_token_id
    branch         = "main"
  }
}

resource "tfe_workspace" "kubernetes-us-central1-b" {
  count                 = 0 # disable this cluster
  name                  = "devops-days-kubernetes-us-central1-b"
  organization          = data.tfe_organization.sic-mundus.name
  description           = "Workspace para Google Kubernetes Engine us-central1-b"
  allow_destroy_plan    = true
  auto_apply            = false
  file_triggers_enabled = true
  speculative_enabled   = true
  trigger_prefixes      = ["3_infraestructura_escalable/kubernetes/*"]
  working_directory     = "3_infraestructura_escalable/kubernetes"

  vcs_repo {
    identifier     = "edam-software/DevOpsDeNoche"
    oauth_token_id = tfe_oauth_client.github_oauth.oauth_token_id
    branch         = "main"
  }

}

resource "tfe_workspace" "servicios-google-cloud" {
  name                  = "devops-days-servicios-google"
  organization          = data.tfe_organization.sic-mundus.name
  description           = "Workspace para IAM y APIs de Google"
  allow_destroy_plan    = true
  auto_apply            = false
  file_triggers_enabled = true
  speculative_enabled   = true
  trigger_prefixes      = ["3_infraestructura_escalable/servicios-google/*"]
  working_directory     = "3_infraestructura_escalable/servicios-google"

  vcs_repo {
    identifier     = "edam-software/DevOpsDeNoche"
    oauth_token_id = tfe_oauth_client.github_oauth.oauth_token_id
    branch         = "main"
  }

}

resource "tfe_workspace" "pipeline" {
  name                  = "devops-days-cicd"
  organization          = data.tfe_organization.sic-mundus.name
  description           = "Workspace para Cloud Build y Cloud Deploy"
  allow_destroy_plan    = true
  auto_apply            = false
  file_triggers_enabled = true
  speculative_enabled   = true
  trigger_prefixes      = ["3_infraestructura_escalable/pipelines/*"]
  working_directory     = "3_infraestructura_escalable/pipelines"

  vcs_repo {
    identifier     = "edam-software/DevOpsDeNoche"
    oauth_token_id = tfe_oauth_client.github_oauth.oauth_token_id
    branch         = "main"
  }
}