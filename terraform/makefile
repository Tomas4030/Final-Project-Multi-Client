.PHONY: init apply-airbnb apply-nike apply-mcdonalds destroy-all

init:
	terraform init -upgrade

define deploy_client
	terraform workspace select $(1) || terraform workspace new $(1)
	terraform apply -auto-approve
endef

apply-airbnb:
	$(call deploy_client,airbnb)

apply-nike:
	$(call deploy_client,nike)

apply-mcdonalds:
	$(call deploy_client,mcdonalds)

update-hosts:
	@echo "Updating /etc/hosts..."
	@IP=$$(minikube ip -p $$(terraform workspace show)-cluster); \
	CLIENT=$$(terraform workspace show); \
	DOMAINS=$$(terraform output -json domains | jq -r '.[]'); \
	for domain in $$DOMAINS; do \
		echo "$$IP $$domain" | sudo tee -a /etc/hosts; \
	done

delete:
	terraform destroy -auto-approve
	minikube delete -p $$(terraform workspace show)-cluster