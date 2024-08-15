pipeline {
    agent { label 'similarity' }
    stages {
        stage('Preparation') {
            when {
                anyOf {
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
        success {
            script {
                def description = "Build Succeeded"
                def status = "SUCCESS"
                def context = "ci/jenkins"
                githubNotify context: context, status: status, description: description
            }
        }
        failure {
            script {
                def description = "Build Failed"
                def status = "FAILURE"
                def context = "ci/jenkins"
                githubNotify context: context, status: status, description: description
            }
        }
    }
}
