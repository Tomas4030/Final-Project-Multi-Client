terraform {
  required_providers {
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
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  alias          = "this"
  config_context = each.key
}