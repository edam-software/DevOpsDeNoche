# cuenta de servicio para correr GKE y acceder a APIs Google
resource "google_service_account" "kubernetes" {
  account_id   = "usuario-gke"
  display_name = "Usuario GKE"
  project      = "days-devops"
}

# cuenta de servicio para correr CloudBuild
resource "google_service_account" "cloudbuild" {
  account_id   = "usuario-cloudbuild"
  display_name = "Usuario Cloudbuild"
  project      = "days-devops"
}

# cuenta de servicio para monitoreo Grafana
resource "google_service_account" "grafana" {
  account_id   = "usuario-grafana"
  display_name = "Usuario Grafana"
  project      = "days-devops"
}

