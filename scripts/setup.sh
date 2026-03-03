#!/bin/bash

echo "🚀 Setting up DevOps project..."

# Install Docker (if not already installed)
if ! command -v docker &> /dev/null; then
    echo "📦 Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
fi

# Install Minikube for local Kubernetes (if not already installed)
if ! command -v minikube &> /dev/null; then
    echo "📦 Installing Minikube..."
    curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
fi

# Start Minikube
echo "🔄 Starting Minikube..."
minikube start --driver=docker

# Enable ingress addon
minikube addons enable ingress

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Build Docker image: docker build -t hello-app:1.0 ."
echo "2. Apply Kubernetes manifests: kubectl apply -f kubernetes/"
echo "3. Check pods: kubectl get pods"
echo "4. Access service: minikube service hello-app-service"
