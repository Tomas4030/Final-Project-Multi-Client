resource "minikube_cluster" "this" {
  driver       = "docker"
  cluster_name = "${local.current_client}-cluster"
  
  # Habilita o addon de Ingress necessário para expor as aplicações
  addons = [
    "ingress",
    "default-storageclass",
    "storage-provisioner"
  ]

  # Só cria se não estivermos no workspace default
  count = local.is_valid_workspace ? 1 : 0
}