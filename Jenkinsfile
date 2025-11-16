pipeline {
    agent any
    
    environment {
        // Utilise les outils déjà installés sur le système
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        M2_HOME = '/usr/share/maven'
        PATH = "${env.JAVA_HOME}/bin:${env.M2_HOME}/bin:${env.PATH}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Récupération du code depuis GitHub...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo '🔨 Construction du projet Maven...'
                sh '''
                    echo "Java version:"
                    java -version
                    echo "Maven version:"
                    mvn -version
                    echo "Construction en cours..."
                    mvn clean package
                '''
            }
        }
        
        stage('Results') {
            steps {
                echo '✅ Vérification des résultats...'
                sh '''
                    echo "=== CONTENU DU DOSSIER target/ ==="
                    ls -la target/
                    echo "=== LIVRABLES ==="
                    find target/ -name "*.jar" -o -name "*.war" 2>/dev/null || echo "Aucun livrable trouvé"
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
