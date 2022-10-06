proyectos = {
  devops = ["network-vpc", "devopsdays"]
}

servicios_devops_days = [
  "compute.googleapis.com",
  "iam.googleapis.com",
  "containerregistry.googleapis.com",
  "cloudbuild.googleapis.com",
  "container.googleapis.com",
  "logging.googleapis.com",
  "speech.googleapis.com"
]

roles_devops_days_gke         = ["roles/container.admin", ]
roles_devops_days_cloud_build = ["roles/cloudbuild.admin", ]