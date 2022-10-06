# usuario creado en servicios-google
data "google_service_account" "cloudbuild" {
  account_id = "usuario-cloudbuild"
}

resource "google_cloudbuild_trigger" "microservices" {
  provider        = google-beta
  location        = var.region
  service_account = data.google_service_account.cloudbuild.id
  filename        = "cloudbuild.yaml"

   substitutions = {
    _REGION = "us-central1"
    _CLUSTER = "google-kubernetes-demo"
  }


  github {
    owner = "edam-software"
    name  = "google-microservices-demo"
    push {
      branch = "^main$"
    }
  }

  options {
    logging = "CLOUD_LOGGING_ONLY"

  }
}

