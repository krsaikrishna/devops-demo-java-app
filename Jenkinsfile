pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "krsaikrishna/hello-app"
        DOCKER_TAG = "${BUILD_NUMBER}"
        DOCKER_REGISTRY = "docker.io"
        KUBECONFIG = "/home/jenkins/.kube/config"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '🔄 Checking out code from GitHub...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo '🔨 Building application with Maven...'
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                echo '✅ Running unit tests...'
                sh 'mvn test'
            }
        }
        
        stage('Package') {
            steps {
                echo '📦 Packaging JAR file...'
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                sh 'docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest'
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                echo '📤 Pushing image to Docker Hub...'
                sh '''
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    docker push ${DOCKER_IMAGE}:latest
                '''
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                echo '☸️  Deploying to Kubernetes...'
                sh '''
                    kubectl set image deployment/hello-app \
                        hello-app=${DOCKER_IMAGE}:${DOCKER_TAG} \
                        --namespace=default || \
                    kubectl apply -f kubernetes/ --namespace=default
                    kubectl rollout status deployment/hello-app
                '''
            }
        }
    }
    
    post {
        success {
            echo '✅ Pipeline succeeded!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}
