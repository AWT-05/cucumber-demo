pipeline{
    agent any

    // environment{
    //     CREDENTIALS_FILE = 'configfile-cucumber-demo-project'
    //     ENV_DEPLOY_NAME = 'DEV' 
    //     //ENV_DEPLOY_NAME = 'QA'
    // }
    stages{
        stage('cucucumber tests'){
            steps{
                withCredentials([file(credentialsId: 'configfile', variable: 'JSONFILE')]) {
                    sh 'chmod +x gradlew'
                    sh "cp \$JSONFILE config.json"
                    //sh './gradlew clean executeBDDTests -PenvironmentName=$ENV_DEPLOY_NAME -PfilterTags=@acceptance'
                    sh './gradlew clean executeBDDTests'
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