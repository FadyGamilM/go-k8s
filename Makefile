SHELL := /bin/bash

run:
	go run main.go

VERSION := 1.0

# ============================= To build docker container out of the service ===================================
all: gok8s

gok8s:
	docker build -f infra/docker/Dockerfile -t go-k8s-img:$(VERSION) --build-arg BUILD_REF=$(VERSION) --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") .

# ============================= To run the image via a k8s with kind ===================================
KIND_CLUSTER := fg-starter-cluster

kind-up:
	kind create cluster --image kindest/node:v1.21.1@sha256:69860bda5563ac81e3c0057d654b5253219618a22ec3a346306239bba8cfa1a6 --name $(KIND_CLUSTER) --config infra/k8s/kind/kind-config.yaml

kind-down:
	kind delete cluster --name $(KIND_CLUSTER)

kind-status:
	kubectl get nodes -o wide 
	kubectl get svc -o wide 