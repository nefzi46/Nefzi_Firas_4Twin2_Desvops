pipeline {
    agent any     // on laisse Jenkins choisir (le master Windows)

    stages {
        stage('Build JAR') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    def image = docker.build("nezras24/nefzi-firas-app:${env.BUILD_NUMBER}")
                    docker.withRegistry('', 'dockerhub-nezras24') {
                        image.push()
                        image.push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            bat 'docker logout || ver > nul'
        }
    }
}
