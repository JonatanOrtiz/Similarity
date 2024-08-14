pipeline {
    agent { label 'similarity' }
    stages {
        stage('Preparation') {
            when {
                anyOf {
                    branch 'main'
                    changeRequest()
                }
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle install'
                }
            }
        }
        stage('Generate Project') {
            when {
                anyOf {
                    branch 'main'
                    changeRequest()
                }
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'make generate'
                }
            }
        }
        stage('Build') {
            when {
                anyOf {
                    branch 'main'
                    changeRequest()
                }
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle exec fastlane build'
                }
            }
        }
        stage('Test') {
            when {
                anyOf {
                    branch 'main'
                    changeRequest()
                }
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle exec fastlane test'
                }
            }
        }
        stage('Cleanup') {
            when {
                anyOf {
                    branch 'main'
                    changeRequest()
                }
            }
            steps {
                echo 'Cleaning up after build'
                dir("$env.PROJECT_PATH") {
                    sh 'rm -rf build/'
                }
            }
        }
    }
    post {
        always {
            echo 'This will always run regardless of the result'
        }
        success {
            echo 'Build and Test Succeeded!'
        }
        failure {
            echo 'Build or Test Failed!'
            dir("$env.PROJECT_PATH") {
                sh 'bundle exec Fastlane send_failure_notification'
            }
        }
    }
}
