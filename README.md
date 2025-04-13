# terraform-aks-helm-nginx
Objective:- Using Terrafrom and helm and Azure capabilities. We will be  setting up Azure Kubernetes Service (AKS) + NGINX + Ingress with SSL using Terraform & Helm.
Method:-

1) Set Up Azure Resources with Terraform
Create Azure Resource Group
Deploy Azure Kubernetes Service (AKS)
Store Terraform state in Azure Storage using, terraform init -reconfigure.

2) Deploy NGINX Using Helm
Install NGINX via Helm
Expose it as a Kubernetes Service

3) Set Up Ingress for Domain Routing
Install NGINX Ingress Controller
Create an Ingress Rule for Terraform-helm-sample.com

4) Enable Offline Domain Resolution
Map Terraform-helm-sample.com to AKS IP in /etc/hosts

6) Add Self-Signed SSL for HTTPS
Create a self-signed TLS certificate
Store it as a Kubernetes Secret
Configure Ingress for HTTPS
