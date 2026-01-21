variable "clients" {
  description = "Map of clients and their environments"
  type        = map(list(string))
  default = {
    airbnb    = ["dev", "prod"]
    nike      = ["dev", "qa", "prod"]
    mcdonalds = ["dev", "qa", "beta", "prod"]
  }
}