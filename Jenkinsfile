pipeline {
  agent {
    docker {
      image 'node:12-alpine'
      args '-p 3000:3000'
    }
  }
    stages {
        stage('Build') { 
            steps {
                sh '${WORKSPACE}\build.sh stage ${BRANCH_NAME} ${BUILD_NUMBER}' 
            }
        }
    }

  }
