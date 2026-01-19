variable "clients" {
  description = "Mapa de clientes e ambientes"
  type = map(list(string))

  default = {
    airbnb = ["dev", "prod"]
    nike = ["dev", "qa", "prod"]
    mcdonalds = ["dev", "qa", "beta", "prod"]
  }
}

