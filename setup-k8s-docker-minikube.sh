#!/bin/bash

# Download kubectl
curl -LO 'https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl'

# Download and verify the kubectl SHA256 checksum
curl -LO "https://dl.k8s.io/v1.22.0/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256) kubectl" | sha256sum --check

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Update package list and install required packages
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker repository
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list and install Docker packages
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add current user to the docker group and refresh group membership
sudo usermod -aG docker $USER && newgrp docker

# Update package list again and install conntrack
sudo apt-get update
sudo apt-get install -y conntrack

# Download minikube
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Install minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "testing"
# Increase netfilter conntrack maximum to avoid potential issues with minikube
sudo sysctl net/netfilter/nf_conntrack_max=524288

echo "testing 1"
# Start minikube and print a success message
sudo minikube start --force && echo "ok: started minikube successfully"

echo "testing 2"
# Change ownership of .kube and .minikube directories to the current user
sudo chown -R $USER.$USER ~/.kube
sudo chown -R $USER.$USER ~/.minikube

sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh
