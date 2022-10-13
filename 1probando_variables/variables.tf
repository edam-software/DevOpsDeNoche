variable "proyectos" {
  type        = map(any)
  description = "Los proyectos para cada área en una variable tipo mapa"
}

variable "lista_uno" {
  type        = list(string)
  description = "Una lista de valores como nombres de usuario, roles, regiones, etc."
}

variable "lista_dos" {
  type        = list(string)
  description = "Una lista de valores asociados como bases de datos, storage buckets, etc."
}

variable "subnets" {
  type = map(object({
    master      = string
    nodos       = string
    secundarios = map(string)
  }))
  description = "Subnets para la Red VPC, la llave es el nombre de la subnet"
}
