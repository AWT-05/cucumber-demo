pipeline{
    agent any
    environment {
        CREDIS = 'configfile'
    }
    stages{
        stage('cucucumber tests'){
            steps{
                withDockerRegistry(file[ credentialsId: "$CREDIS"]) {
                    sh 'chmod +x gradlew'
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