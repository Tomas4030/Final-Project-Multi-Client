module "clusters" {
  for_each = {
    for env in local.environments : env.name => env
  }

  source = "./modules/minikube-cluster"

  name = each.key
}
