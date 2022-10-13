proyectos = {
  devops       = ["devopsdays", "proyecto2", "proyecto3"]
  ingenieria   = ["paquete_correcaminos", "paquete_coyote", "paquete_bugsbunny"]
  contabilidad = ["contabilidad_general", "proyecto1", "consultoria2"]
  ventas       = ["ventas_2022", "ventas_2021"]
  marketing    = ["marketing_2022"]
}

# dos listas con valores asociados
lista_uno = ["base_datos_ventas", "base_datos_clientes", "base_datos_gastos_nube"]
lista_dos = ["usuario_ventas", "usuario_clientes", "usuario_nube"]

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