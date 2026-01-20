locals {
  environments = flatten([
    for client, envs in var.clients : [
      for env in envs : {
        client = lower(client)
        env    = lower(env)
        name   = "${lower(client)}-${lower(env)}"
        domain = "odoo.${lower(env)}.${lower(client)}.local"
      }
    ]
  ])

  env_map = {
    for e in local.environments :
    e.name => e
  }
}
