# SatSure

This repository contains Terraform code to provision infrastructure in the Azure cloud.

## Files

- `setup-k8s-docker-minikube.sh`: This script installs Minikube on the server.

## Improvements

### State Locking with Backend

To ensure consistent state management and to avoid potential issues with concurrent Terraform operations, we can use state locking with a backend. Below is an example of how to configure the `azurerm` backend in your Terraform configuration:

```hcl
terraform {
  backend "azurerm" {
    storage_account_name = "iotfstate"
    container_name       = "tfstate"
    key                  = "ioqa1.tfstate"
  }
}
