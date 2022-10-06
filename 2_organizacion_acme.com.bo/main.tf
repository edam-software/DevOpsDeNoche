terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.39.0"
    }
  }
}

# Formatea la lista de proyectos por area para uso en recursos posteriores
locals {
  areas = [for depto, proyectos in var.proyectos : depto]
  lista_area_proyecto = flatten([
    for depto, proyectos in var.proyectos : [
      for proyecto in proyectos : {
        area     = depto
        proyecto = proyecto
      }
    ]
  ])

  # { days : 'devops' }, {
  proyecto_area = { for obj in local.lista_area_proyecto : obj.proyecto => obj.area }
}

provider "google" {
  # Configuration options
}

# Importar la organizacion con el nombre de dominio aquí y llave de acceso en Variables de Entorno

# en nuestro caso, cuenta personal no cuenta con una organización GCP y los proyectos se crearon manualmente en consola

# Deshabilitamos un recurso Terraform código comentandolo con '#"
# o poniendo count = 0

data "google_organization" "org" {
  domain = "acme.com.bo"
}


# Políticas de Organización - requiere Organización GCP
resource "google_organization_policy" "no_default_network" {
  org_id     = data.google_organization.org.id
  constraint = "compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}

# requiere Organización GCP
resource "google_folder" "folder_depto" {
  for_each     = local.areas
  display_name = each.value
  parent       = data.google_organization.org.name
}

# Nombre será "proyecto-area", proyecto será creado en la carpeta del área
# requiere Organización GCP
resource "google_project" "proyecto_area" {
  for_each            = local.proyecto_area
  name                = each.key
  project_id          = "${each.key}-${each.value}"
  folder_id           = google_folder.folder_depto[each.value].id
  auto_create_network = false
}
