pipeline{
    agent any

    environment{
        CREDENTIALS_FILE = 'configfile-cucumber-demo-project'
        ENV_DEPLOY_NAME = 'DEV' //'QA'
    }
    stages{
        stage('cucucumber tests'){
            steps{
                withCredentials([file(credentialsId: '$CREDENTIALS_FILE', variable: 'JSONFILE')]) {
                    sh 'chmod +x gradlew'
                    sh "cp \$JSONFILE config.json"
                    sh './gradlew clean executeBDDTests PenvironmentName=$ENV_DEPLOY_NAME'
                }       
            }
            post{
            always{
                publishHTML (target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'build/reports/allure-report', reportFiles: 'index.html', reportName: "BDD test Report"])
            }
        }    
        }
        
    }
}