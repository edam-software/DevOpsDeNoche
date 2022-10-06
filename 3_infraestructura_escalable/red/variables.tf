variable "entorno" {
  type        = string
  description = "Entorno  - configurado en Terraform Cloud"
}

variable "region" {
  type        = string
  description = "Region para desplegar Red VPC y subnets - configurado en Terraform Cloud"
}

variable "subnets" {
  type = map(object({
    master      = string
    nodos       = string
    secundarios = map(string)
  }))
  description = "Subnets para la Red VPC, la llave es el nombre de la subnet"
}
