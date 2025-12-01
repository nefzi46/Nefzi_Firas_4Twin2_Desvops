pipeline {
    agent any

    stages {
        stage('Build & Push Docker Image') {
            steps {
                powershell '''
                    docker build -t nezras24/nefzi-firas-app:${BUILD_NUMBER} .
                    docker tag nezras24/nefzi-firas-app:${BUILD_NUMBER} nezras24/nefzi-firas-app:latest
                    docker push nezras24/nefzi-firas-app:${BUILD_NUMBER}
                    docker push nezras24/nefzi-firas-app:latest
                '''
            }
        }
    }
}

