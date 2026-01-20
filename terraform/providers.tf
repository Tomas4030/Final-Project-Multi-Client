terraform {
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}
