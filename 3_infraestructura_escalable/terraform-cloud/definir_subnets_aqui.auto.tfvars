# Definidos en el Workspace Base terraform-cloud en Terraform Cloud
# entorno = "dev"
# project = "days-devops"

subnets = {
  cluster-kubernetes-us-central1-a = {
    master = "10.0.1.0/28"
    nodos  = "10.5.0.0/23"
    secundarios = {
      pods      = "172.16.0.0/15"
      servicios = "172.24.0.0/23"
    }
  }
  cluster-kubernetes-us-central1-b = {
    master = "10.0.2.0/28"
    nodos  = "10.5.2.0/23"
    secundarios = {
      pods      = "172.18.0.0/15"
      servicios = "172.24.2.0/23"
    }
  }
}
