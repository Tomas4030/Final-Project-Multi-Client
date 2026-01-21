locals {
  current_client = terraform.workspace
  # Verifica se o workspace é válido
  is_valid_workspace = contains(keys(var.clients), local.current_client)
  # Define a lista de ambientes (dev, prod, etc)
  current_environments = local.is_valid_workspace ? var.clients[local.current_client] : []
}