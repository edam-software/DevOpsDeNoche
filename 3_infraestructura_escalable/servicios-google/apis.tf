# permitir los servicios API para el proyecto DevOpsDays
resource "google_project_service" "servicios-devops" {
  for_each = toset(var.servicios_devops_days)
  project  = "days-devops"
  service  = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }
  disable_dependent_services = true
}

# permitir los servicios API para el proyecto Red VPC
resource "google_project_service" "servicios-vpc" {
  for_each = toset(var.servicios_red_vpc)
  project  = "network-vpc-364905"
  service  = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }
  disable_dependent_services = true
}
