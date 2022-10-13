# DevOps de Noche :sunrise_over_mountains:

## :cloud: Un repositorio y presentación para DevOps Days La Paz 2022  
Presentación en Apple Keynote:  DevOpsDeNoche.key

## Configuración completa de Google Cloud Platform y Google Kubernetes Engine :mountain_bicyclist:

* incluye red Compute Network
* CICD con Cloud Build y Cloud Deploy
* apps de ejemplo Grafana (monitoreo) y Microservices (ejemplo Google Kubernetes)

---
# :eight_pointed_black_star: Instalación

* Cuenta gratuita de Terraform Cloud y API Token
* Cuenta Free Tier de Google Cloud Platform
* Llave JSON Key de Usuario de Google Cloud con estos permisos
  * Cloud Build Service Agent 
  * Cloud Deploy Admin 
  * Compute Network Admin 
  * Kubernetes Engine Admin 
  * Project IAM Admin 
  * Service Account Admin 
  * Service Account User 
  * Service Usage Admin

* Esta llave se coloca en Terraform Cloud como variable de entorno *GOOGLE_CREDENTIALS*
* Hacer Git Fork del repositorio https://github.com/edam-software/DevOpsDeNoche
* Actualizar *vcs_repo* en los recursos *tfe_workspace* con los datos del Fork en 
  
     3_infraestructura_escalable/terraform-cloud/workspaces.tf

---

# :eight_spoked_asterisk: Configuración de Terraform Cloud para Workspaces y Variables Compartidas

En 3_infraestructura_escalable/terraform-cloud se encuentra la base de la Infraestructura como Código, los 
Workspaces y Variables base de Terraform Cloud.  Primero se configura este Workspace de forma manual con las 
siguientes variables:

* entorno: nombre del entorno como Demo, Dev, Prod
* tfe_email: correo de admin Terraform Cloud
* project: proyecto de GCP
* tfe_org: nombre de Organizacion Terraform Cloud
* region: Region Google Cloud
* oauth_token: un token oauth de Github con permiso para leer el repositorio
* TFE_TOKEN: el User API Token de Terraform Cloud

Con este Workspace inicial se definen otros cuatro Workspaces de Terraform Cloud utilizando el 
[proveedor TFE](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set)
de Hashicorp. De esta forma automatizamos la configuración de Terraform Cloud mismo.

* terraform-cloud - la configuración base que brinda los otros 4 Workspace, y variables compartidas definidas arriba
  * var.region
  * var.subnets
  * var.entorno

De esta forma no es necesario repetir las variables en cada Workspace y configuración.  Una vez creados los 
Workspace de trabajo, se añade la llave JSON de Google Cloud omo variable de entorno *GOOGLE_CREDENTIALS*

---
# :eight_spoked_asterisk: Workspaces de Trabajo

* devops-days-servicios-google
  * Configuración de servicios API Google Cloud Platform
  * Creación de usuario-gke, usuario-cloudbuild y usuario-grafana para correr estos servicios
  * Configuración de Roles IAM para estas cuentas de servicios

* devops-days-red-vpc
  * Configuración de una Red VPC (Google Compute Network), Subnetworks, Router y Cloud NAT 

---
# :eight_spoked_asterisk: Kubernetes

Esto permite crear clusters Kubernetes / Private GKE con subnets ya definidas y con acceso a Internet.  

* devops-days-kubernetes-us-central1-a
  * Para mayor seguridad se configuran GKE Private con nodos privados (sin IP publica). Por conveniencia se mantiene 
    el accesso a Kubernetes master con IP pública.
  * Se puede controlar el acceso con las variables *var.acceso_publico* y *var.cidr_autorizadas*

* devops-days-kubernetes-us-east1-a
  * Se pueden añadir más clusters GKE Kubernetes añadiendo más Workspace, en la configuracion existen dos
  * En Terraform Cloud se define la variable *var.zone* que define la Zona donde colocar el cluster
  * La configuración está basada en una Region Google Cloud y puede tener hasta 4 clusters en cada zona.

---

# :eight_spoked_asterisk: CICD

* devops-days-cicd
  * El último Workspace de Terraform Cloud está dedicado a los Pipelines de CICD
  * Integración Continua con Google Cloud Build
  * Despliegue Continuo con Google Cloud Deploy (un Pipeline gratis en Free Tier, adicionales $15-mes)

--- 

# :space_invader:  Apps de Ejemplo

* Grafana
  * Se despliega Grafana de la siguiente forma:

* Google Microservices
  * Una aplicación de tienda en linea ejemplo de Google Cloud Platform
  * Se despliega de forma automatica a Kubernetes utilizando Cloud Build y Skaffold
  * Se debe hacer Git Fork del repo https://github.com/edam-software/google-microservices-demo


---
Tabla de Contenido del Repositorio

# Capítulo Zero: Formato y pruebas de variables Terraform
[1 Probando Variables](1probando_variables/readme.md)

# Capítulo Uno: Diseñando Organizacion Google en Terraform para Escalar a Trescientos Desarrolladores.

[2 Arquitectura de la Organización DevOps](2_organizacion_acme.com.bo/readme.md)

# Capítulo Dos: Definir la Organizacion, Roles y Permisos en Terraform
[3 Terraform Cloud, GCP Network, Kubernetes, IAM](3_infraestructura_escalable/servicios-google/readme.md)

# Capítulo Tres: Kubernetes, Red VPC

[3 Kubernetes](3_infraestructura_escalable/kubernetes/readme.md)
[3 Red VPC](3_infraestructura_escalable/red)

# Capítulo Cuatro: CI/CD y Pipelines para Desarrollo y Publicacion Agiles
[3 Pipelines](3_infraestructura_escalable/pipelines)
