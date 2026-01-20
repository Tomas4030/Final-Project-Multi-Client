output "domains" {
	value = [for e in local.environments : e.domain]
}

output "domain_clusters" {
	value = { for e in local.environments : e.domain => e.name }
}

output "clusters" {
	value = [for e in local.environments : e.name]
}
