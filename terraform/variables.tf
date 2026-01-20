variable "clients" {
  type = map(list(string))
  default = {
    airbnb    = ["dev", "prod"]
    nike      = ["dev", "qa", "prod"]
    mcdonalds = ["dev", "qa", "beta", "prod"]
  }
}

variable "minikube_driver" {
  type    = string
  default = "docker"
}

variable "minikube_addons" {
  type    = list(string)
  default = ["ingress"]
}

variable "minikube_memory_gb" {
  type    = number
  default = 1
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "odoo_image" {
  type    = string
  default = "odoo:16"
}

variable "postgres_image" {
  type    = string
  default = "postgres:14"
}

variable "postgres_user" {
  type    = string
  default = "odoo"
}

variable "postgres_password" {
  type    = string
  default = "odoo"
}
