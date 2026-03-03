# DevOps Demo Project: Java Application CI/CD Pipeline

## Overview
This is a beginner-friendly DevOps project that demonstrates a complete CI/CD pipeline using:
- **GitHub** - Source code management
- **Jenkins** - Continuous Integration & Deployment
- **Maven** - Build automation
- **Docker** - Containerization
- **Kubernetes** - Orchestration

## Architecture
```
GitHub (Push Code)
    ↓
Jenkins (Triggered by Webhook)
    ↓ (Build & Test with Maven)
    ↓
Docker (Build & Push Image)
    ↓
Kubernetes (Deploy & Run)
```

## Prerequisites
- Linux/Mac/Windows (with WSL)
- Docker installed
- Maven installed (or use Docker image)
- kubectl installed
- Minikube installed (for local K8s testing)
- GitHub account
- Docker Hub account
- Jenkins server (local or cloud)

## Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/krsaikrishna/devops-demo-java-app.git
cd devops-demo-java-app
```

### 2. Run Locally with Docker
```bash
# Build Docker image
docker build -t hello-app:1.0 .

# Run container
docker run -p 8080:8080 hello-app:1.0

# Test the application
curl http://localhost:8080/
curl http://localhost:8080/health
```

### 3. Deploy to Local Kubernetes (Minikube)
```bash
# Start Minikube
minikube start --driver=docker

# Apply Kubernetes manifests
kubectl apply -f kubernetes/

# Check pods
kubectl get pods

# Access the service
minikube service hello-app-service --url
```

### 4. CI/CD Pipeline Setup (Jenkins)

#### Jenkins Configuration:
1. **Create New Pipeline Job** in Jenkins
2. **Connect GitHub Repository**:
   - Go to Job → Configure
   - Add Git repository URL
   - Set branch: `main` or `master`

3. **Add Webhook to GitHub**:
   - Settings → Webhooks → Add webhook
   - Payload URL: `http://jenkins-server:8080/github-webhook/`
   - Content type: `application/json`
   - Select events: `Push events`

4. **Configure Jenkins Pipeline**:
   - Pipeline script from SCM
   - SCM: Git
   - Repository URL: (your GitHub repo)
   - Script path: `Jenkinsfile`

5. **Set Docker Hub Credentials**:
   - Jenkins → Manage Credentials
   - Add Docker Hub username and password token
   - Reference in Jenkinsfile: `DOCKER_USERNAME` and `DOCKER_PASSWORD`

6. **Configure Kubernetes Access**:
   - Copy kubeconfig to Jenkins server
   - Or use service account for K8s authentication

## Project Structure
```
.
├── src/
│   ├── main/java/com/demo/         # Java source code
│   └── test/java/com/demo/         # Unit tests
├── kubernetes/
│   ├── deployment.yaml             # K8s Deployment manifest
│   ├── service.yaml                # K8s Service manifest
│   └── configmap.yaml              # K8s ConfigMap
├── scripts/
│   ├── setup.sh                    # Initial setup script
│   └── deploy.sh                   # Deployment script
├── Dockerfile                       # Container image definition
├── Jenkinsfile                      # CI/CD pipeline definition
├── pom.xml                          # Maven build configuration
└── README.md                        # This file
```

## Build & Test Locally

```bash
# Build with Maven
mvn clean package

# Run tests
mvn test

# Run the application
java -jar target/hello-app-1.0.0.jar
```

## Monitoring & Debugging

```bash
# Check pod logs
kubectl logs -f deployment/hello-app

# Describe pod
kubectl describe pod <pod-name>

# Port forward to local machine
kubectl port-forward service/hello-app-service 8080:80

# Check all resources
kubectl get all -n default
```

## Troubleshooting

### Jenkins not connecting to GitHub
- Ensure webhook URL is correct and reachable
- Check Jenkins logs for errors
- Verify GitHub token permissions

### Docker image push fails
- Verify Docker Hub credentials
- Ensure image name matches registry format
- Check Docker daemon is running

### Kubernetes deployment fails
- Check image exists on Docker Hub
- Verify kubeconfig permissions
- Check resource quotas: `kubectl describe resourcequota`

## Learning Resources
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Docker Official Docs](https://docs.docker.com/)
- [Kubernetes Tutorials](https://kubernetes.io/docs/tutorials/)
- [Maven Guide](https://maven.apache.org/guides/)
- [Spring Boot Docs](https://spring.io/projects/spring-boot)

