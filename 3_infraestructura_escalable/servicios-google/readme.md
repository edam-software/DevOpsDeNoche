# Configuración Básica de IAM para brindar APIs y roles seguros

En *main.tf* configuramos 3 cuentas de servicios:  Usuario Cloud Build, Usuario GKE, y Usuario Grafana.

## Usuario Cloud Build

Este usuario se utiliza para crear y correr builds con Google Cloud Build, configurados en 
*3_infraestructura_escalable/pipelines*

## Usuario Kubernetes

El *usuario-gke* se configura en *3_infraestructura_escalable/kubernetes* para utilizar Workload Identity y brindar 
acceso a los microservicios y aplicaciones que corren en Kubernetes, hacia las APIs y servicios de Google.

Por ejemplo, para poder utilizar imagenes Docker desde nuestro repositorio en Google Container Registry *gcr.
io/days-devops* le brindamos el permiso para leer objetos Storage. Los Storage.objectViewer permite abrir tanto 
contenedores en gcr.io como Buckets en Cloud Storage


    roles_devops_days_gke = [
      "roles/container.admin",
      "roles/speech.admin",
      "roles/secretmanager.admin",
      "roles/storage.objectViewer"
    ]


## Usuario Grafana

El *usuario-grafana* es una cuenta de servicios para activar el Data Source de Google Monitoring en Grafana. Para 
poder recibir metricas del cluster Kubernetes y de los servidores Compute VM solamente brindamos este permiso


    roles_devops_days_grafana = [
     "roles/monitoring.viewer"
    ]
