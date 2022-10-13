# enlaza el usuario de servicio GKE con Kubernetes y Workload identity
#gcloud iam service-accounts add-iam-policy-binding GSA_NAME@GSA_PROJECT.iam.gserviceaccount.com \
#    --role roles/iam.workloadIdentityUser \
#    --member "serviceAccount:PROJECT_ID.svc.id.goog[NAMESPACE/KSA_NAME]"
resource "google_service_account_iam_binding" "workload_identity" {
  service_account_id = google_service_account.kubernetes.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${google_service_account.kubernetes.email}"
  ]

  condition {
    title       = "expires_after_2023_12_31"
    description = "Expiring at midnight of 2023-12-31"
    expression  = "request.time < timestamp(\"2024-01-01T00:00:00Z\")"
  }
}

# asigna permisos para GKE y APIs Google
resource "google_project_iam_member" "permisos_gke" {
  for_each = toset(var.roles_devops_days_gke)
  project  = "days-devops"
  role     = each.value
  member   = "serviceAccount:${google_service_account.kubernetes.email}"

  condition {
    title       = "expires_after_2023_12_31"
    description = "Expiring at midnight of 2023-12-31"
    expression  = "request.time < timestamp(\"2024-01-01T00:00:00Z\")"
  }
}

resource "google_project_iam_member" "permisos_cloudbuild" {
  for_each = toset(var.roles_devops_days_cloud_build)
  project  = "days-devops"
  role     = each.value

  member = "serviceAccount:${google_service_account.cloudbuild.email}"

  condition {
    title       = "expires_after_2023_12_31"
    description = "Expiring at midnight of 2023-12-31"
    expression  = "request.time < timestamp(\"2024-01-01T00:00:00Z\")"
  }

}

resource "google_project_iam_member" "permisos_grafana" {
  for_each = toset(var.roles_devops_days_grafana)
  project  = "days-devops"
  role     = each.value

  member = "serviceAccount:${google_service_account.grafana.email}"

  condition {
    title       = "expires_after_2023_12_31"
    description = "Expiring at midnight of 2023-12-31"
    expression  = "request.time < timestamp(\"2024-01-01T00:00:00Z\")"
  }
}