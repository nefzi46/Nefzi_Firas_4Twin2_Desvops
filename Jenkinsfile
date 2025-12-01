pipeline {
    agent {
        docker {
            image 'maven:3.9.9-eclipse-temurin-17'
            label 'docker-agent'                     // fonctionne même sur Windows
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // très important !
        }
    }

    environment {
        IMAGE_NAME = "nezras24/nefzi-firas-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {
        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    def customImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                    docker.withRegistry('', 'dockerhub-nezras24') {
                        customImage.push()
                        customImage.push("latest")
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}
