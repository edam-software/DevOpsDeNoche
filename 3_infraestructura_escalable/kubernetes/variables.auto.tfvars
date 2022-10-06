entorno = "demo"

subnets = {
  cluster-kubernetes = {

    # https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#cluster_sizing_primary_range

    # 500 Nodos Kubernetes, 50,000 pods, 512 servicios. Se puede crear subnet para cada cluster, o compartirlo
    master = "10.0.1.0/28"
    nodos  = "10.5.0.0/23"
    secundarios = {
      pods      = "172.16.0.0/15"
      servicios = "172.24.0.0/23"
    }
  }
}

# por zona, 3 zonas en region us-central1
min_nodos = 1
max_nodos = 3
