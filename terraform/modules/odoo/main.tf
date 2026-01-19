resource "kubernetes_namespace" "ns" {
  metadata {
    name = "${var.client}-${var.env}"
  }
}

resource "kubernetes_deployment" "odoo" {
  metadata {
    name      = "odoo"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "odoo"
      }
    }

    template {
      metadata {
        labels = {
          app = "odoo"
        }
      }

      spec {
        container {
          name  = "odoo"
          image = "odoo:16"

          port {
            container_port = 8069
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "odoo" {
  metadata {
    name      = "odoo"
    namespace = kubernetes_namespace.ns.metadata[0].name
  }

  spec {
    selector = {
      app = "odoo"
    }

    port {
      port        = 80
      target_port = 8069
    }
  }
}
