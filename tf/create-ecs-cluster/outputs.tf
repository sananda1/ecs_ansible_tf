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
