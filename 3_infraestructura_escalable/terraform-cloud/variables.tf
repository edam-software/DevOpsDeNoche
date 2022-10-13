variable "entorno" {
  type        = string
  description = "Entorno Demo, Dev, Prod"
}

variable "project" {
  type        = string
  description = "Proyecto en Google Cloud"
}

variable "region" {
  type        = string
  description = "Region de Google Cloud para los recursos"
}

variable "subnets" {
  type = map(object({
    master      = string
    nodos       = string
    secundarios = map(string)
  }))
  description = "Subnets para la Red VPC, la llave es el nombre de la subnet"
}

variable "tfe_org" {
  type        = string
  description = "Organizacion en Terraform Cloud"
}
variable "tfe_email" {
  type        = string
  description = "Email admin de Terraform Cloud"
}

variable "oauth_token" {
  type        = string
  description = "Github Oauth Token"
}
