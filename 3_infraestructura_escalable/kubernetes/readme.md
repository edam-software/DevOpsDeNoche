# por defecto la configuracion requiere configurar redes en variable cidr_autorizadas

para deshabilitar esto y permitir acceso autenticado global

     gcloud container clusters update CLUSTER_NAME --no-enable-master-authorized-networks

Esto se requiere para utilizar CloudBuild ya que no podemos crear un Private Worker Pool en cuenta GCP gratuita.

Para entrar en producción se recomienda utilizar Private Worker Pool on master-authorized networks y deshabilitar el 
public endpoint de GKE.
