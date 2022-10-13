data "google_compute_network" "red-vpc" {
  name = "red-vpc-${var.entorno}"
}

# utiliza la misma variable var.subnets que la carpeta red
# mediante Variable Set de Terraform Cloud
data "google_compute_subnetwork" "kubernetes-subnets" {
  for_each = var.subnets
  name     = "${each.key}-${var.entorno}"
}

# usuario creado en servicios-google
data "google_service_account" "kubernetes" {
  account_id = "usuario-gke"
}

resource "google_container_cluster" "kubernetes" {
  provider   = google-beta
  depends_on = [data.google_compute_network.red-vpc, data.google_service_account.kubernetes]
  lifecycle {
    ignore_changes = [initial_node_count]
  }
  name            = "google-kubernetes-${var.entorno}"
  location        = var.zone
  network         = data.google_compute_network.red-vpc.self_link
  subnetwork      = data.google_compute_subnetwork.kubernetes-subnets["cluster-kubernetes-${var.zone}"].self_link
  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "servicios"
  }
  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }

  remove_default_node_pool = true
  initial_node_count       = 1
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = var.acceso_publico ? false : true
    master_global_access_config {
      enabled = false
    }
    master_ipv4_cidr_block = var.subnets["cluster-kubernetes-${var.zone}"]["master"]
  }

  release_channel {
    channel = "REGULAR"
  }

  master_authorized_networks_config {

    dynamic "cidr_blocks" {
      for_each = toset(var.cidr_autorizadas)
      content {
        cidr_block = cidr_blocks.value
      }
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }
}

resource "google_container_node_pool" "spot_nodes" {
  lifecycle {
    ignore_changes = [initial_node_count]
  }
  provider           = google-beta
  name               = "spot-node-pool-${var.entorno}"
  cluster            = google_container_cluster.kubernetes.id
  location           = var.zone
  initial_node_count = 1

  network_config {
    create_pod_range = false
    pod_range        = "pods"
  }
  autoscaling {
    max_node_count = var.max_nodos
    min_node_count = var.min_nodos
  }
  node_config {
    spot         = var.spot
    machine_type = var.tipo_maquina

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  management {
    auto_repair  = true
    auto_upgrade = true
  }
  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }
}
