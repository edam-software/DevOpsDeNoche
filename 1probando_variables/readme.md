# Manipulando variables y valores Terraform 

Utilizando los constructos *for* y las funciones *flatten* , *tomap*, *zipmap* y *merge* podemos manipular listas y 
mapas de variables para utilizar con recursos Terraform.

Empezamos con un mapa *proyectos* con llave *departamento* y valores en una lista *["proyecto1", "proyecto2", 
"proyecto3" ]* en el archivo de definicion *proyectos.auto.tfvars*

    proyectos = {
    devops       = ["devopsdays", "proyecto2", "proyecto3"]
    ingenieria   = ["paquete_correcaminos", "paquete_coyote", "paquete_bugsbunny"]
    contabilidad = ["contabilidad_general", "proyecto1", "consultoria2"]
    ventas       = ["ventas_2022", "ventas_2021"]
    marketing    = ["marketing_2022"]
    }

En el archivo *prueba_variables.tf* realizamos la creacion de variables *locales*

    areas = [for depto, proyectos in var.proyectos : depto]
   
    lista_area_proyecto = flatten([
        for depto, proyectos in var.proyectos : [
            for proyecto in proyectos : {
                area     = depto
                proyecto = proyecto
            }
        ]
    ])

    proyecto_area = { for obj in local.lista_area_proyecto : obj.proyecto => obj.area }

    
Luego podemos verificar los valores generados usando *terraform console*

    > local.areas
        [
          "contabilidad",
          "devops",
          "ingenieria",
          "marketing",
          "ventas",
        ]
    
    > local.proyecto_area
        {
          "consultoria2" = "contabilidad"
          "contabilidad_general" = "contabilidad"
          "devopsdays" = "devops"
          "marketing_2022" = "marketing"
          "paquete_bugsbunny" = "ingenieria"
          "paquete_correcaminos" = "ingenieria"
          "paquete_coyote" = "ingenieria"
          "proyecto1" = "contabilidad"
          "proyecto2" = "devops"
          "proyecto3" = "devops"
          "ventas_2021" = "ventas"
          "ventas_2022" = "ventas"
        }

    > local.mapa_usuario_base_datos
        tomap({
          "base_datos_clientes" = "usuario_clientes"
          "base_datos_gastos_nube" = "usuario_nube"
          "base_datos_ventas" = "usuario_ventas"
        })
    > local.acceso_base_datos
        [
          "base_datos_clientes@usuario_clientes",
          "base_datos_gastos_nube@usuario_nube",
          "base_datos_ventas@usuario_ventas",
        ]

Podemos utilizar estas variables locales para configurar recursos Terraform con las directivas *count*, *for_each* y 
tambien con bloques *dynamicos*.  

Tambien se pueden definir variables de tipo *object(map)* de forma similar a clases en Python o Java

Definicion del objeto en  *variables.tf*

    variable "subnets" {
      type = map(object({
        master      = string
        nodos       = string
        secundarios = map(string)
      }))
      description = "Subnets para la Red VPC, la llave es el nombre de la subnet"
    }

Configuramos los subnets en *variables.auto.tfvar*

    subnets = {
      cluster-kubernetes = {
        master = "10.0.1.0/28"
        nodos  = "10.5.0.0/23"
        secundarios = {
          pods      = "172.16.0.0/15"
          servicios = "172.24.0.0/23"
        }
      }
    }


En 3_infraestructura_escalable/red.tf utilizamos el mapa de *subnets* y extraemos cada subnet para 
configurar el recurso *google_compute_router_nat*

     resource "google_compute_router_nat" "nat" {
      ...
      
        dynamic "subnetwork" {
            for_each = google_compute_subnetwork.kubernetes-subnets
            content {
              name                    = subnetwork.value.self_link
              source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
            }
        }
