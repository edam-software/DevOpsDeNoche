# Importar proyecto red vpc creados anteriormente
data "google_project" "red-vpc" {
  project_id = "network-vpc-364905"
}

# importar proyecto devops para crear el enlace Shared Host VPC
data "google_project" "days-devops" {
  project_id = "days-devops"
}

data "google_service_account" "usuario-gke" {
  project    = data.google_project.days-devops.project_id
  account_id = "usuario-gke"
}

# La red donde pondremos clusters de Kubernetes
resource "google_compute_network" "red-vpc" {
  project                 = data.google_project.red-vpc.project_id
  name                    = "red-vpc-${var.entorno}"
  auto_create_subnetworks = false
  mtu                     = 1460
}

# configuramos varias subnets, cada una con un rango secundario para Pods y otro para Servicios Kubernetes
resource "google_compute_subnetwork" "kubernetes-subnets" {
  for_each      = var.subnets
  name          = "${each.key}-${var.entorno}"
  ip_cidr_range = each.value["nodos"]
  region        = var.region
  project       = data.google_project.red-vpc.project_id
  network       = google_compute_network.red-vpc.id

  # pods y servicios
  dynamic "secondary_ip_range" {
    for_each = each.value["secundarios"]
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

# habilita el proyecto network-vpc-364905 para compartir su red a otros proyectos
resource "google_compute_shared_vpc_host_project" "host" {
  count   = 0 # requiere Organización GCP
  project = data.google_project.red-vpc.project_id
}

# configura los otros proyectos para compartir la red VPC del proyecto network-vpc-364905
# requiere Organización GCP
resource "google_compute_shared_vpc_service_project" "devopsdays_red_compartida" {
  count           = 0 # requiere Organización GCP
  host_project    = data.google_project.red-vpc.project_id
  service_project = data.google_project.days-devops.project_id
}

data "google_iam_policy" "subnet-access" {
  binding {
    role    = "roles/compute.instanceAdmin"
    members = [
      "serviceAccount:${data.google_service_account.usuario-gke.email}",
    ]
  }

  binding {
    role = "roles/compute.networkUser"

    members = [
      "serviceAccount:${data.google_service_account.usuario-gke.email}",
    ]
  }
}
# restringe el acceso de days-devops a subnets definidas
resource "google_compute_subnetwork_iam_policy" "subnet-binding" {
  for_each    = google_compute_subnetwork.kubernetes-subnets
  project     = each.value.project
  region      = each.value.region
  subnetwork  = each.value.name
  policy_data = data.google_iam_policy.subnet-access.policy_data
}
