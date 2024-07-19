# Repository Overview

This repository consists of Kubernetes manifests in Helm templates, integrated with ArgoCD for continuous deployment in Kubernetes.

## Folder Structure

### `app`

In the `app` folder, we have ArgoCD application manifests that provide a UI for each application.

### `bootstrap`

The `bootstrap` folder contains the actual application manifests in Helm templates. These include:

1. `grafana-stack`
2. `nginx-ingress-controller` for exposing the services
3. `cert-manager` for SSL certificates provisioning automation
4. `rbac` for fine-grained control over the resources

### `charts`

In this folder, we have code for ArgoCD.

## Setup Instructions

### Prerequisites

- A containerization platform like Kubernetes
- Helm installed on your local machine
- Clone the repository

### Initialization

Execute the following commands after filling in the required details:

```sh
helm dependency build charts/argo-cd/
helm dependency update charts/argo-cd/
helm upgrade --install argo-cd charts/argo-cd/ --create-namespace --debug -n argocd

### Deploy Application

apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: io-base
spec:
  destination:
    name: ''
    namespace: io-base
    server: 'https://kubernetes.default.svc'
  source:
    path: apps
    repoURL: ''
    targetRevision: HEAD
  project: default
  syncPolicy:
    automated:
      prune: true
    syncOptions:
      - Validate=false
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
      - PruneLast=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m

