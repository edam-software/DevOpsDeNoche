data "google_compute_network" "red-vpc" {
  name    = "red-vpc-${var.entorno}"
}

resource "google_cloudbuild_worker_pool" "private_pool" {
  count = 0 # requiere cuenta pagada
  name = "private_pool-${var.entorno}"
  location = var.region

  network_config {
    peered_network = data.google_compute_network.red-vpc.id
  }
  worker_config {
    disk_size_gb = 100
    machine_type = "e2-medium"
    no_external_ip = false
  }
}