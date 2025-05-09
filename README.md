***Objective***:- Using Terrafrom and helm and Azure capabilities. We will be  setting up Azure Kubernetes Service (AKS) + NGINX + Ingress with SSL using Terraform & Helm.

***Prerequisites***:-
  * Azure CLI installed and authenticated.
  * Terraform installed.
  * Helm installed.
  * kubectl installed.
  * Access to an Azure subscription.

***Project Structure***:
  helm-terraform-aks/
  │── terraform/                # Terraform code for AKS
  │   ├── main.tf
  │   ├── variables.tf
  │   ├── outputs.tf
  │   ├── terraform.tfvars
  │   ├── versions.tf        # Azure provider configuration
  │── helm/                     # Helm chart for NGINX
  │   ├── charts/
  │   ├── templates/
  │   │   ├── deployment.yaml
  │   │   ├── service.yaml
  │   │   ├── ingress.yaml
  │   ├── values.yaml
  │   ├── tls.crt
  │   ├── tls.key
  │   ├── Chart.yaml
  │── .gitignore                # Git ignore file
  │── README.md                 # Documentation


***Steps***:-

***1) Set Up Azure Resources with Terraform.***
    * Create Azure Resource Group.
    * Deploy Azure Kubernetes Service (AKS).
    * Store Terraform state in Azure Storage.
    * Get the Kubeconfig to connect to the AKS cluster.

    cd AKSTerraform/terraform-manifests
    az login # to login to Azure account
    az account set --subscription <your-subscription-id> # Set the subscription ID
    Terraform init;
    Terraform plan;
    Terraform apply; # to create the Azure resources
    

***2) Deploy NGINX Using Helm***

    * Create helm chart for NGINX
        helm create nginx      # already attached in the repo Helm\nginx
    * Install NGINX via Helm
        helm install nginx ./nginx --namespace <my-namespace> --kubeconfig /path/to/kubeconfig
    * Test if Nginx is properly installed using kubeproxy command
        kubectl port-forward svc/nginx 8080:80 -n <namespace>



***3) Set Up Ingress for Domain Routing***
    
   * Install NGINX Ingress Controller with with default --ingress-class value which is nginx

      helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
      helm repo update
      kubectl create namespace ingress-nginx
      helm install ingress-nginx ingress-nginx/ingress-nginx \
      --namespace ingress-nginx \
      --set controller.replicaCount=1 \
      --set controller.nodeSelector."kubernetes\.io/os"=linux \
      --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
      --set controller.service.externalTrafficPolicy=Local \
      --set controller.service.type=LoadBalancer


  * Create an Ingress Rule for Terraform-helm-sample.com
      updated values.yaml for ingress by making the following changes:
        ingress:
          enabled: true
          className: nginx  # Set the ingress class name to nginx coming from the ingress-nginx controller
          annotations: 
            nginx.ingress.kubernetes.io/rewrite-target: /
          hosts:
            - host: myapp.com
              paths:
              - path: /
                pathType: Prefix

***4) Enable Offline Domain Resolution***
  * Map myapp.com to AKS IP in /etc/hosts
      kubectl get svc ingress-nginx-controller -n ingress-nginx # Get the external IP of the ingress-nginx-controller service
  * sudo nano /etc/hosts and add the following line
   <EXTERNAL-IP>   myapp.com

***5) Add Self-Signed SSL for HTTPS***
  * Create a self-signed TLS certificate
      openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      keyout tls.key -out tls.crt \
    -subj "/CN=myapp.com/O=myapp.com"
  * Store it as a Kubernetes Secret in the namespave where NGINX is deployed
      kubectl create secret tls myapp-tls --cert=tls.crt --key=tls.key -n <namespace>
  * Configure values.yaml for HTTPS
     updated values.yaml for tls by making the following changes:
        tls:
          - hosts:
            - myapp.com
            secretName: myapp-tls # Name of the secret created above
     helm upgrade --install nginx ./nginx --namespace my-namespace --kubeconfig /path/to/kubeconfig





