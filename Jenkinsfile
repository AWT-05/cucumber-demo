pipeline{
    agent any
    stages{
        stage('cucucumber tests'){
            steps{
                sh 'chmod +x gradlew'
                sh './gradlew clean executeBDDTests'
            }    
        }
        always{
                publishHTML (target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'build/reports/allure-report', reportFiles: 'index.html', reportName: "BDD test Report"])
        }
    }
}