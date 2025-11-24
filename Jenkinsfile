pipeline {
agent any
environment {
DOCKERHUB = credentials('dockerhub-creds')
SSH_CRED = 'ec2-ssh-key'
APP_IMAGE = "kowsie/capstone-node-app"
APP_TAG = "${env.BUILD_NUMBER}"
DEPLOY_USER = "ubuntu"
DEPLOY_HOST = "13.233.236.137"
DEPLOY_PATH = "/home/ubuntu/devops-capstone/deploy"
}
stages {
stage('Checkout') { steps { checkout scm } }
stage('Install & Test') {
steps {
sh 'npm ci'
sh 'npm test || true'
}
}
stage('Build Docker Image') { steps { sh "docker build -t ${APP_IMAGE}:${APP_TAG} ." } }
stage('Login & Push Image') {
steps {
withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
sh "echo $DH_PASS | docker login -u $DH_USER --password-stdin"
sh "docker push ${APP_IMAGE}:${APP_TAG}"
}
}
}
stage('Deploy to EC2') {
steps {
sshagent (credentials: ['ec2-ssh-key']) {
sh "scp -o StrictHostKeyChecking=no deploy/deploy.sh ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}/deploy.sh"
sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} 'bash ${DEPLOY_PATH}/deploy.sh ${APP_IMAGE} ${APP_TAG}'"
}
}
}
}
post {
    always {
        archiveArtifacts artifacts: '**/logs/*.log', allowEmptyArchive: true, onlyIfSuccessful: false
    }
}
}
