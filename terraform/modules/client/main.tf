terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

locals {
  # Naming convention: client-environment
  namespace   = "${var.client_name}-${var.environment}"
  app_name    = "odoo"
  domain_name = "odoo.${var.environment}.${var.client_name}.local"
}

# 1. Namespace
resource "kubernetes_namespace" "env" {
  metadata {
    name = local.namespace
  }
}

# 2. TLS Certificates (HTTPS Requirement)
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "cert" {
  private_key_pem = tls_private_key.pk.private_key_pem

  subject {
    common_name  = local.domain_name
    organization = "Cloud Platform Eng"
  }

  validity_period_hours = 24 * 365

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "kubernetes_secret" "tls" {
  metadata {
    name      = "${local.app_name}-tls"
    namespace = kubernetes_namespace.env.metadata[0].name
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = tls_self_signed_cert.cert.cert_pem
    "tls.key" = tls_private_key.pk.private_key_pem
  }
}

# 3. Database (StatefulSet Requirement)
resource "kubernetes_stateful_set" "db" {
  metadata {
    name      = "postgres-db"
    namespace = kubernetes_namespace.env.metadata[0].name
  }
  spec {
    service_name = "postgres"
    replicas     = 1
    selector {
      match_labels = { app = "postgres" }
    }
    template {
      metadata {
        labels = { app = "postgres" }
      }
      spec {
        container {
          name  = "postgres"
          image = "postgres:13"
          env {
            name  = "POSTGRES_USER"
            value = "odoo"
          }
          env {
            name  = "POSTGRES_PASSWORD"
            value = "odoo"
          }
          env {
            name  = "POSTGRES_DB"
            value = "postgres"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "db" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.env.metadata[0].name
  }
  spec {
    selector = { app = "postgres" }
    port {
      port        = 5432
      target_port = 5432
    }
  }
}

# 4. Odoo Application (Deployment)
resource "kubernetes_deployment" "odoo" {
  metadata {
    name      = local.app_name
    namespace = kubernetes_namespace.env.metadata[0].name
    labels    = { app = local.app_name }
  }

  spec {
    replicas = 1
    selector {
      match_labels = { app = local.app_name }
    }
    template {
      metadata {
        labels = { app = local.app_name }
      }
      spec {
        container {
          name  = "odoo"
          image = "odoo:15"
          port {
            container_port = 8069
          }
          # Conectar ao DB
          env {
            name  = "HOST"
            value = "postgres"
          }
          env {
            name  = "USER"
            value = "odoo"
          }
          env {
            name  = "PASSWORD"
            value = "odoo"
          }
        }
      }
    }
  }
  depends_on = [kubernetes_service.db]
}

# 5. Service Odoo
resource "kubernetes_service" "odoo" {
  metadata {
    name      = "${local.app_name}-svc"
    namespace = kubernetes_namespace.env.metadata[0].name
  }
  spec {
    selector = { app = local.app_name }
    port {
      port        = 80
      target_port = 8069
    }
    type = "ClusterIP"
  }
}

# 6. Ingress (HTTPS Exposure)
resource "kubernetes_ingress_v1" "odoo" {
  metadata {
    name      = "${local.app_name}-ingress"
    namespace = kubernetes_namespace.env.metadata[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-redirect" = "true"
    }
  }

  spec {
    ingress_class_name = "nginx"

    tls {
      hosts       = [local.domain_name]
      secret_name = kubernetes_secret.tls.metadata[0].name
    }

    rule {
      host = local.domain_name
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.odoo.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}