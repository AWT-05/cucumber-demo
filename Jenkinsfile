pipeline{
    agent any
    environment {
        CREDENTIALS_FILE = 'configfile-cucumber-demo-project'     
    }
    parameters {
        string(name: 'TAG_NAME', defaultValue: " ", description: 'Tag to run specific tests'),
        string(name: 'ENV_NAME', defaultValue: "DEV", description: 'Environment to execute test')
    }
    stages {
        stage('Build'){ 
            steps{
                sh 'chmod +x gradlew'
                sh './gradlew clean build'  
            }
            post {
            always{
                publishHTML (target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'build/reports/tests/test', reportFiles: 'index.html', reportName: "MOI-project test Report"])
                }
            success {
                archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
                }
            }  
        }
        stage('BDD tests'){
            steps {
                withCredentials([file(credentialsId: "${CREDENTIALS_FILE}", variable: 'JSONFILE')]) {
                    sh 'chmod +x gradlew'
                    sh "cp \$JSONFILE config.json"
                    sh './gradlew clean executeBDDTests -PenvironmentName=$ENV_NAME -PfilterTags=$TAG_NAME'
                }       
            }
            post {
            always {
                script {
                    allure([includeProperties: false, jdk: '', properties: [], reportBuildPolicy: 'ALWAYS', results: [[path: 'build/allure-results']]])
                    }
                }
            }    
        }
    }
}