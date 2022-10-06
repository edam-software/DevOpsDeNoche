##   Primero creamos el Cloud Deploy Delivery Pipeline y un Target que es el cluster Kubernetes en cloud_deploy.tf

###   Ahora podemos utilizar skaffold desde la linea de comando para generar un skaffold.yaml con los manifiestos Grafana

    skaffold init --skip-build

###   El comando Google Cloud Deploy utilizar skaffold.yaml para enviar los manifiestos a Kubectl mediante Cloud Build

###   En Cloud Build, podemos ver los pasos del despliegue y el resultado en Cloud Deploy. 

###   El manifiesto Ingress genera una IP efimera donde podemos acceder a Grafana: 
http://34.102.231.195/d/T2EMZSS4z/http-s-lb-backend-services?orgId=1

    gcloud deploy releases create grafana-ingress --project=days-devops \
       --delivery-pipeline=pipeline-demo --region=us-central1 \
       --to-target=google-kubernetes-demo-target
