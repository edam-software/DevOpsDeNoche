resource "google_clouddeploy_target" "primary" {
  location = var.region
  name     = "google-kubernetes-demo-target"

  description = "Desplegar App al Cluster Kubernetes Demo"

  gke {
    cluster     = "projects/days-devops/locations/us-central1/clusters/google-kubernetes-demo"
    internal_ip = false
  }
  require_approval = false
}

resource "google_clouddeploy_delivery_pipeline" "primary" {
  location = var.region
  name     = "pipeline-${var.entorno}"
  description = "Desplegar apps a Kubernetes"

  serial_pipeline {
    stages {
      profiles  = []
      target_id = google_clouddeploy_target.primary.name
    }

  }
}
