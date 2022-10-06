terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.39.0"
    }
  }
}

locals {
  areas = [for depto, proyectos in var.proyectos : depto]
  lista_area_proyecto = flatten([
    for depto, proyectos in var.proyectos : [
      for proyecto in proyectos : {
        area     = depto
        proyecto = proyecto
  }]])

  proyecto_area = { for obj in local.lista_area_proyecto : obj.proyecto => obj.area }
}


resource "local_file" "pruebas" {
  for_each = local.proyecto_area
  filename = "${path.module}/${each.key}_${each.value}.txt"
  content  = "Proyecto: ${each.key} Area: ${each.value}"
}

resource "null_resource" "proyectos_area" {
  for_each = local.proyecto_area
  provisioner "local-exec" {
    command = "echo Proyecto:${each.key} Area:${each.value}"
  }
}
