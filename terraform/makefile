
.PHONY: init validate plan apply test run destroy all

init:
	@echo "📦 Initializing Terraform..."
	terraform init

validate:
	@echo "🔍 Validating Terraform..."
	terraform validate

plan-apply:
	@echo "⚡ Generating Terraform plan..."
	terraform plan -out=k8s.plan 
	terraform apply k8s.plan

test:
	@echo "🩺 Checking Kubernetes resources..."
	kubectl get pods -A
	kubectl get svc -A
	kubectl get ingress -A


run: init validate plan-apply test
	@echo "✅ SYSTEM ONLINE"

destroy:
	@echo "💥 Destroying Terraform resources..."
	terraform destroy -auto-approve

all: run