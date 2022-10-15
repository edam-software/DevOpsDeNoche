resource "google_clouddeploy_target" "primary" {
  location = var.region
  name     = "${var.entorno}-central1-a-target"

  description = "Desplegar App al Cluster Kubernetes Demo"

  gke {
    cluster     = "projects/days-devops/locations/us-central1-a/clusters/google-kubernetes-dev"
    internal_ip = false
  }
  require_approval = false
}

resource "google_clouddeploy_target" "secondary" {
  location = var.region
  name     = "${var.entorno}-central1-b-target"

  description = "Desplegar App al Cluster Kubernetes Demo"

  gke {
    cluster     = "projects/days-devops/locations/us-central1-b/clusters/google-kubernetes-dev"
    internal_ip = false
  }
  require_approval = false
}

resource "google_clouddeploy_delivery_pipeline" "primary" {
  location    = var.region
  name        = "pipeline-demo"
  description = "Desplegar apps a Kubernetes"

  serial_pipeline {
    stages {
      profiles  = []
      target_id = google_clouddeploy_target.primary.name
    }

    stages {
      profiles  = []
      target_id = google_clouddeploy_target.secondary.name
    }

  }
}
