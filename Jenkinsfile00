pipeline {
    agent any
    
    tools {
        // Utilise les noms EXACTS configurés dans Jenkins
        maven 'M2_HOME'
        jdk 'JAVA_HOME'
    }
    
    stages {
        stage('Vérification outils') {
            steps {
                echo '🔧 Vérification des versions...'
                sh '''
                    echo "=== VERSION JAVA ==="
                    java -version
                    echo "=== VERSION MAVEN ==="
                    mvn -version
                    echo "=== VARIABLES D'ENVIRONNEMENT ==="
                    echo "JAVA_HOME: $JAVA_HOME"
                    echo "M2_HOME: $M2_HOME"
                '''
            }
        }
        
        stage('Checkout') {
            steps {
                echo '📥 Récupération du code depuis GitHub...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo '🔨 Construction du projet Maven...'
                sh 'mvn clean package -DskipTests'
            }
        }
        
        stage('Results') {
            steps {
                echo '✅ Vérification des résultats...'
                sh '''
                    echo "=== CONTENU TARGET ==="
                    ls -la target/
                    echo "=== LIVRABLES ==="
                    find target/ -name "*.jar" -o -name "*.war" 2>/dev/null
                '''
            }
        }
    }
    
    post {
        always {
            echo '🏁 Pipeline terminé'
        }
        success {
            echo '🎉 SUCCÈS! Construction réussie!'
            archiveArtifacts 'target/*.jar,target/*.war'
        }
        failure {
            echo '❌ ÉCHEC de la construction'
        }
    }
}
