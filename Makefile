SHELL := /bin/bash

run:
	go run main.go

VERSION := 1.0

all: gok8s

gok8s:
	docker build -f infra/docker/Dockerfile -t go-k8s-img:$(VERSION) --build-arg BUILD_REF=$(VERSION) --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") .
