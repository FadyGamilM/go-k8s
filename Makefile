SHELL := /bin/bash

run-sales-api:
	go run ./app/services/sales-api/main.go

VERSION := 1.0

# ============================= To build docker container out of the service ===================================
all: sales-api

sales-api:
	docker build -f infra/docker/Dockerfile.sales-api -t sales-api-img:$(VERSION) --build-arg BUILD_REF=$(VERSION) --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") .

# ============================= To run the image via a k8s with kind ===================================
KIND_CLUSTER := fg-starter-cluster

kind-up:
	kind create cluster --image kindest/node:v1.21.1@sha256:69860bda5563ac81e3c0057d654b5253219618a22ec3a346306239bba8cfa1a6 --name $(KIND_CLUSTER) --config infra/k8s/kind/kind-config.yaml

kind-set-namespace:
	kubectl config set-context --current --namespace=gok8s-system

kind-down:
	kind delete cluster --name $(KIND_CLUSTER)

kind-status-nodes:
	$(info printing info about k8s cluster nodes)
	kubectl get nodes -o wide --namespace=gok8s-system

kind-status-services:
	$(info printing info about k8s cluster services)
	kubectl get svc -o wide --namespace=gok8s-system

kind-status-pods:
	$(info printing info about k8s cluster pods)
	kubectl get pod -o wide --watch --namespace=gok8s-system

kind-status:
	kubectl get nodes -o wide --namespace=gok8s-system
	kubectl get svc -o wide --namespace=gok8s-system
	kubectl get pod -o wide --watch --namespace=gok8s-system


# load our local image into the kind environment 
# anytime we change the image we have to reload it into the kind environment
kind-load:
	kind load docker-image sales-api-img:$(VERSION) --name $(KIND_CLUSTER)


# kustomize will produce a yaml file to apply it to the kubectl tooling 
kind-apply:
	kubectl apply -f ./infra/k8s/base/gok8s-pod/base-gok8s.yaml

kind-logs:
	kubectl logs -l app=sales-api-pod --all-containers=true -f --tail=100 

kind-restart:
	kubectl rollout restart deployment gok8s-depl --namespace=gok8s-system

# to notice that we have a change in the image so we have to build, then load the newely built image in the cluster, and finally restart the image 
kind-update: all kind-load kind-restart
