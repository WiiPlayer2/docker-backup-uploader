pipeline {
    agent {
        label 'docker'
    }

    environment {
        IMAGE = "backup-uploader"
        REGISTRY = "registry.dark-link.info"
        CREDENTIALS_ID = "vserver-container-registry"
    }

    stages {
        stage('Build') {
            steps {
                sh "docker build -t ${IMAGE}:latest --pull ."
            }
        }

        stage('Publish') {
            steps {
                withDockerRegistry([credentialsId: "${CREDENTIALS_ID}", url: "https://${REGISTRY}/"]) {
                    sh "docker tag ${IMAGE}:latest ${REGISTRY}/${IMAGE}:latest"
                    sh "docker image push ${REGISTRY}/${IMAGE}:latest"
                }
            }
        }
    }
}
