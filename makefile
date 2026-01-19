terraform_dir = terraform

.PHONY: init apply-plan

delete:
	minikube delete --all

init:
	cd $(terraform_dir); \
	terraform init

apply-plan:
	cd $(terraform_dir); \
	terraform plan -out=save.plan; \
	terraform apply save.plan




