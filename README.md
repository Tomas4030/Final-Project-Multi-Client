# Multi-Client Kubernetes Platform (Terraform + Minikube)


terraform/
├── main.tf              # module loop for clients/envs
├── variables.tf         # clients map
├── locals.tf            # flatten + domains
├── providers.tf         # required_providers
├── minikube.tf          # cria clusters
├── outputs.tf
└── modules/
    └── environment/
        ├── main.tf      # namespace, odoo, db, ingress
        ├── tls.tf       # certificados
        └── providers.tf # kubernetes provider (1 por cluster)
