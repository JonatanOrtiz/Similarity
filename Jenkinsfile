pipeline {
    agent { label 'similarity' }
    options {
        timeout(time: 8, unit: 'HOURS')
        disableConcurrentBuilds(abortPrevious: true)
    }
    stages {
        stage('Certificados e Perfis') {
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle exec fastlane match appstore'
                }
            }
        }
        stage('Upload to App Store') {
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle exec fastlane upload_to_appstore'
                }
            }
        }
    }
    post {
        success {
            echo 'Upload to App Store Succeeded!'
        }
        failure {
            echo 'Upload to App Store Failed!'
            dir("$env.PROJECT_PATH") {
                sh 'bundle exec fastlane send_failure_notification'
            }
        }
        always {
            cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
        }
    }
}
