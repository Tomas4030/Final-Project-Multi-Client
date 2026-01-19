locals {
  environments = flatten([
    for client, envs in var.clients : [
      for env in envs : {
        client = client
        env    = env
        name   = "${client}-${env}"
        domain = "odoo.${env}.${client}.local"
      }
    ]
  ])
}
