output "current_client" {
  description = "The client currently deployed in this workspace"
  value       = local.current_client
}

output "domains" {
  description = "Domains to add to /etc/hosts"
  value = [
    for env in local.current_environments :
    "odoo.${env}.${local.current_client}.local"
  ]
}

output "minikube_ip" {
  description = "Run 'minikube ip -p <workspace>-cluster' to get this"
  value       = "Run: minikube ip -p ${local.current_client}-cluster"
}