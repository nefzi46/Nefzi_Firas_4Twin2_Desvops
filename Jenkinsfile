pipeline {
    agent any
    
    tools {
        maven 'M2_HOME'
        jdk 'JAVA_HOME'
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                echo '📥 Récupération du code depuis GitHub...'
                checkout scm
            }
        }
        
        stage('Build Maven') {
            steps {
                echo '🔨 Construction du projet Maven...'
                sh 'mvn clean package'
            }
        }
        
        stage('Verify Results') {
            steps {
                echo '✅ Vérification du livrable...'
                sh '''
                    echo "=== FICHIERS GÉNÉRÉS ==="
                    ls -la target/
                    echo "=== LIVRABLES TROUVÉS ==="
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
            echo '🎉 SUCCÈS: Construction réussie!'
            archiveArtifacts 'target/*.jar,target/*.war'
        }
        failure {
            echo '❌ ÉCHEC: La construction a échoué'
        }
    }
}
