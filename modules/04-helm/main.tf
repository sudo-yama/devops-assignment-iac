terraform {
  required_providers {
    google = {
        source  = "hashicorp/google"
        version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/03-gke"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket  = "000-gcs-terraform-state"
    prefix  = "terraform/dev/01-vpc"
  }
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${data.terraform_remote_state.gke.outputs.gke_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.gke.outputs.gke_ca)
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.terraform_remote_state.gke.outputs.gke_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.gke.outputs.gke_ca)
  }
}

resource "kubernetes_namespace" "ingress_namespace" {
  metadata {
    name = var.ingress_namespace
  }
}

resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    name = var.argocd_namespace
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_namespace.metadata.0.name

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }

  set {
    name  = "controller.admissionWebhooks.enabled"
    value = "false"
  }
}

data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-ingress-nginx-controller"
    namespace = kubernetes_namespace.ingress_namespace.metadata.0.name
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "6.7.11"
  namespace  = kubernetes_namespace.argocd_namespace.metadata.0.name

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set_list {
    name  = "server.ingress.paths"
    value = ["/"]
  }

  set {
    name  = "server.ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name  = "server.ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "nginx"
  }
}
