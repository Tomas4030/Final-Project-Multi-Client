module "environment" {
	for_each = local.env_map

	source = "./modules/environment"

	name_prefix            = each.key
	namespace              = each.value.name
	domain                 = each.value.domain
	odoo_image             = var.odoo_image
	postgres_image         = var.postgres_image
	postgres_user          = var.postgres_user
	postgres_password      = var.postgres_password

	depends_on = [minikube_cluster.cluster]
}
