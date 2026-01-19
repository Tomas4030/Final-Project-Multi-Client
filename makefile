apply:
	terraform init
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

hosts:
	./scripts/update-hosts.sh $$(terraform output -json domains | jq -r '.[]')

validate:
	./scripts/validate.sh
