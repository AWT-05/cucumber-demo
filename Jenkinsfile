pipeline{
    agent any

    environment {
        CREDENTIALS_FILE = 'configfile-cucumber-demo-project'
        ENV_DEPLOY_NAME = 'DEV' //'QA'
        
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
                    sh './gradlew clean executeBDDTests -PenvironmentName=${ENV_DEPLOY_NAME} -PfilterTags=@acceptance'
                }       
            } 
            post {
            always{
                allure([includeProperties: false, jdk: 'Java', properties: [], reportBuildPolicy: 'ALWAYS', results: [[path: '/build/reports/allure-report']]])
                }
            } 
        }   
    }
}