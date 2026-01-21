provider "kubernetes" {
  host = local.is_valid_workspace ? minikube_cluster.this[0].host : ""

  client_certificate     = local.is_valid_workspace ? minikube_cluster.this[0].client_certificate : ""
  client_key             = local.is_valid_workspace ? minikube_cluster.this[0].client_key : ""
  cluster_ca_certificate = local.is_valid_workspace ? minikube_cluster.this[0].cluster_ca_certificate : ""
}