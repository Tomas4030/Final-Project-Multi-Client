terraform {
  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.4.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source = "hashicorp/local"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}