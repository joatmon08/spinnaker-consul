kubernetes-cluster:
	cd cluster && terraform apply
	gcloud container clusters get-credentials spinnaker-demo --zone us-central1-c

helm-update:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update
	helm repo add grafana https://grafana.github.io/helm-charts
	helm repo update
	helm repo add hashicorp https://helm.releases.hashicorp.com
	helm repo update
	helm repo add minio https://helm.min.io
	helm repo update

kubernetes-deploy:
	cd kubernetes && terraform apply

kubernetes-deploy-app:
	cd kubernetes && terraform apply -var="consul_is_available=true"

spinnaker-deploy:
	bash spinnaker.sh
	hal deploy apply

connect:
	bash connect.sh

spinnaker-pipelines:
	spin application save -f spinnaker/application.json
	spin canary canary-config save --file spinnaker/canary-config.json
	spin pipeline save -f spinnaker/delete.json
	spin pipeline save -f spinnaker/deploy.json
	spin canary canary-config save --file spinnaker/canary-config.json

load-test:
	k6 run -e UI_ENDPOINT=$(shell cd kubernetes && terraform output -raw ui_endpoint) k6/script.js --duration 60m

clean-connect:
	bash shutdown.sh || true

clean-spinnaker:
	hal deploy clean || true

clean-kubernetes:
	cd kubernetes && terraform destroy -auto-approve -var="consul_is_available=true"

clean-cluster:
	cd cluster && terraform destroy -auto-approve

clean: clean-connect clean-spinnaker clean-kubernetes clean-cluster