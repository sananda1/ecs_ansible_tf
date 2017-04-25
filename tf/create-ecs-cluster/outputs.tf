#update outputs if you add additonal containers
output "jira_url" {
	value = "${module.atb-jira.public_dns}"
}

output "confluence_url" {
	value = "${module.atb-confluence.public_dns}"
}

output "bamboo_url" {
	value = "${module.atb-bamboo.public_dns}"
}

output "monitoring_url" {
	value = "${module.atb-monitoring.public_dns}"
}

output "crucible_fisheye_url" {
	value = "${module.atb-crucible_fisheye.public_dns}"
}
