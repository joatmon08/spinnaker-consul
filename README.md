# Automating Canary Deployments with HashiCorp Consul & Spinnaker

This repository contains demonstration code to spin up HashiCorp Consul,
Prometheus, and Spinnaker on Google Kubernetes Engine to demonstrate
automated canary deployments.

## Requirements

- Terraform 0.14+
- Kubernetes 1.18+
- Consul 1.9+
- Spinnaker 1.24.4
    - [Halyard](https://spinnaker.io/setup/install/halyard/) 1.41.1+
    - [Spin](https://spinnaker.io/setup/spin/) 1.20+

## Run

To run, you must run the commands in order in the `Makefile`.

## Access

- Grafana
    - Port forward from Kubernetes
    - http://localhost:3000
    - Username: `admin`, Password: `password`
    - Dashboard: `Applications`

- Consul
    - Port forward from Kubernetes
    - http://localhost:8500

- Application (UI)
    - Load balancer in GKE
    - `http://<load balancer endpoint>:9090/ui`

- Spinnaker
    - Port forward using `hal deploy connect`
    - UI: http://localhost:9000
    - API: http://localhost:8084 (for spin CLI)
