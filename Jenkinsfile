pipeline{
    agent any

    stages{
        stage('cucucumber tests'){
            steps{
                withCredentials([file(credentialsId: 'configfile', variable: 'JSONFILE')]) {
                    sh 'chmod +x gradlew'
                    h "cp \$JSONFILE config.json"
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