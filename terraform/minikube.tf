resource "minikube_cluster" "cluster" {
  cluster_name       = "multi-client"
  driver             = var.minikube_driver
  addons             = var.minikube_addons
  kubernetes_version = var.kubernetes_version
  memory             = "${var.minikube_memory_gb}g"
}
