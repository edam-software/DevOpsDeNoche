variable "proyectos" {
  type        = map(any)
  description = "Los proyectos para cada área en una variable tipo mapa"
}

variable "servicios_devops_days" {
  type        = list(string)
  description = "Los servicios API que utilizara el proyecto DevOpsDays"
}

variable "roles_devops_days_gke" {
  type        = list(string)
  description = "Los servicios API que utilizara el proyecto DevOpsDays para Kubernetes"
}


variable "roles_devops_days_cloud_build" {
  type        = list(string)
  description = "Los servicios API que utilizara el proyecto DevOpsDays para Pipeline"
}
