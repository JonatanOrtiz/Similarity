pipeline {
    agent { label 'similarity' }
    options {
        timeout(time: 8, unit: 'HOURS')
        disableConcurrentBuilds(abortPrevious: true)
    }
    stages {
        stage('Preparation') {
            when {
                changeRequest()
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle install'
                }
            }
        }
        stage('Generate Project') {
            when {
                changeRequest()
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'make generate'
                }
            }
        }
        stage('Build') {
            when {
                changeRequest()
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle exec fastlane build'
                }
            }
        }
        stage('Test') {
            when {
                changeRequest()
            }
            steps {
                dir("$env.PROJECT_PATH") {
                    sh 'bundle exec fastlane test'
                }
            }
        }
        stage('Cleanup') {
            when {
                changeRequest()
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
        success {
            echo 'Build and Test Succeeded!'
        }
        failure {
            echo 'Build or Test Failed!'
            dir("$env.PROJECT_PATH") {
                sh 'bundle exec fastlane send_failure_notification'
            }
        }
	always {
            cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenSuccess: true, cleanWhenUnstable: true, deleteDirs: true)
        }
    }
}