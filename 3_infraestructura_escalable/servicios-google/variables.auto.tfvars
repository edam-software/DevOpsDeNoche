proyectos = {
  devops = ["network-vpc", "days"]
}

servicios_red_vpc = [
  "compute.googleapis.com",
  "iam.googleapis.com",
  "logging.googleapis.com",
  "cloudresourcemanager.googleapis.com",
  "dns.googleapis.com"
]

servicios_devops_days = [
  "compute.googleapis.com",
  "iam.googleapis.com",
  "containerregistry.googleapis.com",
  "cloudbuild.googleapis.com",
  "container.googleapis.com",
  "logging.googleapis.com",
  "speech.googleapis.com",
  "cloudresourcemanager.googleapis.com",
  "dns.googleapis.com",
  "clouddeploy.googleapis.com",
  "monitoring.googleapis.com",
  "artifactregistry.googleapis.com"
]

roles_devops_days_gke = [
  "roles/container.admin",
  "roles/speech.admin",
  "roles/secretmanager.admin",
]

#  https://cloud.google.com/vpc/docs/shared-vpc#iam_in_shared_vpc
# roles/container.hostServiceAgentUser
# Allows the Kubernetes Engine service account in the host project to configure shared network resources for cluster management. Also gives access to inspect the firewall rules in the host project.

# roles/storage.admin
# Cloud Build Service Account, Firebase Admin and API Keys Admin
roles_devops_days_cloud_build = [
  "roles/cloudbuild.builds.builder",
  "roles/iam.serviceAccountUser",
  "roles/secretmanager.admin",
  "roles/container.admin",
  "roles/clouddeploy.admin"
]

roles_devops_days_grafana = [
 "roles/monitoring.viewer"
]