variable "entorno" {
  type        = string
  description = "Entorno  - configurado en Terraform Cloud"
}

variable "region" {
  type        = string
  description = "Region para el Router Google (no puede ser por zona)"
}

variable "min_nodos" {
  type        = number
  description = "Cantidad minima de Nodos en el cluster Kubernetes"
}

variable "max_nodos" {
  type        = number
  description = "Cantidad maxima de Nodos en el cluster Kubernetes"
}

variable "tipo_maquina" {
  type        = string
  description = "Utilizar VMs de Google de este tipo"
  default     = "e2-medium"
}

variable "spot" {
  type        = bool
  description = "Utilizar VMs de Google efimeras y baratas (Preemptible)"
  default     = true
}


variable "acceso_publico" {
  type        = bool
  description = "Permitir acceso publico a kubectl. Si no, requiere una VM en la VPC o configuracion adicional de Cloud VPN"
  default     = true
}

variable "cidr_autorizadas" {
  type        = list(string)
  description = "Permitir acceso publico a kubectl desde estas CIDR"
  default     = []
}

variable "subnets" {
  type = map(object({
    master      = string
    nodos       = string
    secundarios = map(string)
  }))
  description = "Subnets para la Red VPC, la llave es el nombre de la subnet"
}
