resource "null_resource" "cluster" {
  triggers = {
    name = var.name
  }

  provisioner "local-exec" {
    command = <<EOT
      minikube start \
        -p ${var.name} \
        --driver=docker
      EOT
  }
}
