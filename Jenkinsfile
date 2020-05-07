pipeline{
    agent any

    environment {
        CREDENTIALS_FILE = 'configfile-cucumber-demo-project'
        //ENV_DEPLOY_NAME = 'DEV' 
        //ENV_DEPLOY_NAME = 'QA'
    }
    stages {
        stage('BDD tests'){
            steps {
                withCredentials([file(credentialsId: "${CREDENTIALS_FILE}", variable: 'JSONFILE')]) {
                    sh 'chmod +x gradlew'
                    sh "cp \$JSONFILE config.json"
                    sh './gradlew clean executeBDDTests -PenvironmentName=$ENV_DEPLOY_NAME -PfilterTags=@acceptance'
                    //sh './gradlew clean executeBDDTests'
                    //sh './gradlew clean executeBDDTests -PenvironmentName=DEV -PfilterTags=@acceptance'
                }       
            }  
        }
        
    }
}