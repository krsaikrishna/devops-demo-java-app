#!/bin/bash

set -e

echo "📦 Building Docker image..."
docker build -t krsaikrishna/hello-app:latest .

echo "📤 Pushing to Docker Hub..."
docker push krsaikrishna/hello-app:latest

echo "☸️  Applying Kubernetes manifests..."
kubectl apply -f kubernetes/

echo "⏳ Waiting for deployment to be ready..."
kubectl rollout status deployment/hello-app

echo "✅ Deployment complete!"
echo ""
echo "Service URL:"
minikube service hello-app-service --url
