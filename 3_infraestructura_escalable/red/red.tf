# La red donde pondremos clusters de Kubernetes
# en el mismo proyecto porque no se cuenta con una Organización para Shared VPC (ver carpeta "red")
resource "google_compute_network" "red-vpc" {
  name                    = "red-vpc-${var.entorno}"
  provider                = google-beta
  auto_create_subnetworks = false
  mtu                     = 1460
}

# configuramos varias subnets, cada una con un rango secundario para Pods y otro para Servicios Kubernetes
resource "google_compute_subnetwork" "kubernetes-subnets" {
  for_each                 = var.subnets
  name                     = "${each.key}-${var.entorno}"
  provider                 = google-beta
  ip_cidr_range            = each.value["nodos"]
  network                  = google_compute_network.red-vpc.id
  private_ip_google_access = true

  # pods y servicios
  dynamic "secondary_ip_range" {
    for_each = each.value["secundarios"]
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

resource "google_compute_router" "router-para-nat" {
  name     = "router-vpc-${var.entorno}"
  provider = google-beta
  network  = google_compute_network.red-vpc.name
  bgp {
    asn = 64514
  }
}

# permite acceso afuera desde subnets
resource "google_compute_router_nat" "nat" {
  name                               = "red-vpc-nat-${var.entorno}"
  provider                           = google-beta
  router                             = google_compute_router.router-para-nat.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  dynamic "subnetwork" {
    for_each = google_compute_subnetwork.kubernetes-subnets
    content {
      name                    = subnetwork.value.self_link
      source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
    }
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
