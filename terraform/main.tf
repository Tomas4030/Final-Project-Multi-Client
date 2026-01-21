resource "time_sleep" "wait_for_ingress" {
  depends_on = [minikube_cluster.this]

  create_duration = "90s" # Tempo para o Nginx Ingress Controller iniciar
}

module "odoo_stack" {
  source = "./modules/client"

  # Se isto der erro, verifica o locals.tf
  for_each = toset(local.current_environments)

  # Estas variáveis TÊM de existir dentro do modules/client/variables.tf
  client_name = local.current_client
  environment = each.key
  
  # Isto só funciona se o recurso no clusters.tf se chamar "this"
  depends_on = [time_sleep.wait_for_ingress]
}